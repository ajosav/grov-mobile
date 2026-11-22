import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/presentation/cubit/auth_error.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_effect.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

void main() {
  late FakeAuthRepository repo;
  setUp(() => repo = FakeAuthRepository());

  SignOnCubit build() => signOnCubitFor(repo);
  final next = DateTime.utc(2026, 11, 22, 10, 1);

  group('continue with email', () {
    test('a bad email is caught before the server', () async {
      final c = build()..emailChanged('nope');
      await c.continueWithEmail();
      expect(c.state.error, AuthError.invalidEmail);
      expect(repo.calls, isEmpty);
      await c.close();
    });

    test('asks for the code and opens the code screen', () async {
      repo.requestCodeResult = Result.ok(challengeAt(next));
      final c = build()..emailChanged(' ngozi@example.com ');
      await c.continueWithEmail();
      expect(repo.calls, ['requestCode:ngozi@example.com']);
      expect(c.state.busy, isFalse);
      expect(c.state.codeNextSendAt, next);
      expect(c.state.effect, const SignOnEffect.toCode());
      await c.close();
    });

    test('there is no lookup: a new and an existing address do the same', () async {
      repo.requestCodeResult = Result.ok(challengeAt(next));
      final a = build()..emailChanged('new@example.com');
      final b = build()..emailChanged('old@example.com');
      await a.continueWithEmail();
      await b.continueWithEmail();
      expect(a.state.effect, b.state.effect);
      await a.close();
      await b.close();
    });

    test('too soon still opens the code screen with the server time', () async {
      repo.requestCodeResult = Result.err(
        RateLimitedFailure('x', 'OTP_RESEND_TOO_SOON', {
          'nextSendAt': next.toIso8601String(),
        }),
      );
      final c = build()..emailChanged('ngozi@example.com');
      await c.continueWithEmail();
      expect(c.state.error, isNull);
      expect(c.state.codeNextSendAt, next);
      expect(c.state.effect, const SignOnEffect.toCode());
      await c.close();
    });

    test('too soon without a time is an error, not a dead end', () async {
      repo.requestCodeResult = const Result.err(
        RateLimitedFailure('x', 'OTP_RESEND_TOO_SOON'),
      );
      final c = build()..emailChanged('ngozi@example.com');
      await c.continueWithEmail();
      expect(c.state.error, AuthError.resendTooSoon);
      expect(c.state.effect, isNull);
      await c.close();
    });

    test('offline is reported and nothing opens', () async {
      repo.requestCodeResult = const Result.err(OfflineFailure());
      final c = build()..emailChanged('ngozi@example.com');
      await c.continueWithEmail();
      expect(c.state.error, AuthError.offline);
      expect(c.state.busy, isFalse);
      expect(c.state.effect, isNull);
      await c.close();
    });

    test('a second tap while busy is ignored', () async {
      repo.requestCodeResult = Result.ok(challengeAt(next));
      final c = build()..emailChanged('ngozi@example.com');
      await Future.wait([c.continueWithEmail(), c.continueWithEmail()]);
      expect(repo.calls.length, 1);
      await c.close();
    });
  });

  group('terms', () {
    test('load, accept', () async {
      final c = build();
      await c.loadTermsVersion();
      expect(c.state.termsVersion, 'terms-test');
      c.setTermsAccepted(true);
      expect(c.state.termsAccepted, isTrue);
      await c.close();
    });

    test('cannot accept before the version is known', () async {
      final c = build()..setTermsAccepted(true);
      expect(c.state.termsAccepted, isFalse);
      await c.close();
    });

    test('a failed load is reported and can be retried', () async {
      repo.termsVersionResult = const Result.err(OfflineFailure());
      final c = build();
      await c.loadTermsVersion();
      expect(c.state.error, AuthError.offline);
      repo.termsVersionResult = const Result.ok('terms-test');
      await c.loadTermsVersion();
      expect(c.state.termsVersion, 'terms-test');
      expect(c.state.error, isNull);
      await c.close();
    });
  });

  group('complete profile', () {
    Future<SignOnCubit> ready() async {
      final c = build()..emailChanged('ngozi@example.com');
      await c.loadTermsVersion();
      c.setTermsAccepted(true);
      return c;
    }

    Future<void> submit(
      SignOnCubit c, {
      String first = ' Ngozi ',
      String last = ' Okafor ',
      String phone = '0803 123 4567',
    }) => c.completeProfile(
      ticket: 'ticket-of-a-new-address',
      firstName: first,
      lastName: last,
      phone: phone,
    );

    test('sends the ticket, trimmed names, +234 phone and terms', () async {
      repo.completeProfileResult = Result.ok(outcomeWith(AuthGate.none));
      final c = await ready();
      await submit(c);
      final sent = repo.lastProfile!;
      expect(sent.ticket, 'ticket-of-a-new-address');
      expect(sent.firstName, 'Ngozi');
      expect(sent.lastName, 'Okafor');
      expect(sent.phone, '+2348031234567');
      expect(sent.termsVersion, 'terms-test');
      expect(c.state.signingIn, isTrue);
      expect(c.state.effect, isA<SignOnSignedIn>());
      c.effectHandled();
      expect(c.state.signingIn, isFalse);
      await c.close();
    });

    test('terms not accepted: nothing is sent', () async {
      final c = build();
      await c.loadTermsVersion();
      await submit(c);
      expect(repo.lastProfile, isNull);
      await c.close();
    });

    test('a bad phone never reaches the server', () async {
      final c = await ready();
      await submit(c, phone: '123');
      expect(c.state.error, AuthError.phoneInvalid);
      expect(repo.lastProfile, isNull);
      await c.close();
    });

    test('a blank last name is not sent', () async {
      final c = await ready();
      await submit(c, last: '  ');
      expect(repo.lastProfile, isNull);
      await c.close();
    });

    test('a phone on another account is reported, nothing opens', () async {
      repo.completeProfileResult = const Result.err(
        ConflictFailure('x', 'PHONE_TAKEN'),
      );
      final c = await ready();
      await submit(c);
      expect(c.state.error, AuthError.phoneTaken);
      expect(c.state.busy, isFalse);
      expect(c.state.effect, isNull);
      await c.close();
    });

    test('stale terms clear the choice so they are fetched again', () async {
      repo.completeProfileResult = const Result.err(
        ConflictFailure('x', 'AUTH_TERMS_VERSION_STALE'),
      );
      final c = await ready();
      await submit(c);
      expect(c.state.error, AuthError.termsStale);
      expect(c.state.termsVersion, isNull);
      expect(c.state.termsAccepted, isFalse);
      await c.close();
    });

    test('an expired ticket is reported so the screen can start over', () async {
      repo.completeProfileResult = const Result.err(
        ValidationFailure({}, 'x', 'OTP_REGISTRATION_INVALID'),
      );
      final c = await ready();
      await submit(c);
      expect(c.state.error, AuthError.ticketExpired);
      await c.close();
    });

    test('a step the app cannot finish is not a sign-in', () async {
      repo.completeProfileResult = const Result.ok(outcomeNoSession);
      final c = await ready();
      await submit(c);
      expect(c.state.error, AuthError.unsupportedStep);
      expect(c.state.signingIn, isFalse);
      await c.close();
    });
  });
}
