import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/domain/entities/account_lookup.dart';
import 'package:app_mobile/features/auth/domain/entities/auth_provider.dart';
import 'package:app_mobile/features/auth/domain/entities/otp_challenge.dart';
import 'package:app_mobile/features/auth/domain/entities/password_check.dart';
import 'package:app_mobile/features/auth/domain/entities/password_problem.dart';
import 'package:app_mobile/features/auth/presentation/cubit/auth_error.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_cubit.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_effect.dart';
import 'package:app_mobile/features/auth/presentation/cubit/sign_on_state.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

Matcher _state({bool? busy, AuthError? error, Object? effect}) =>
    isA<SignOnState>()
        .having((s) => s.busy, 'busy', busy ?? anything)
        .having((s) => s.error, 'error', error ?? anything)
        .having((s) => s.effect, 'effect', effect ?? anything);

void main() {
  late FakeAuthRepository repo;
  setUp(() => repo = FakeAuthRepository());

  SignOnCubit build() => signOnCubitFor(repo);

  group('continue with email', () {
    blocTest<SignOnCubit, SignOnState>(
      'a new email goes to join',
      setUp: () => repo.lookupResult = const Result.ok(
        AccountLookup(exists: false, hasPassword: false),
      ),
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        await c.continueWithEmail();
      },
      expect: () => [
        _state(),
        _state(busy: true),
        _state(busy: false, effect: isA<SignOnToJoin>()),
      ],
      verify: (_) => expect(repo.calls, ['lookup:ngozi@example.com']),
    );

    blocTest<SignOnCubit, SignOnState>(
      'an email with a password goes to log-in',
      setUp: () => repo.lookupResult = const Result.ok(
        AccountLookup(exists: true, hasPassword: true),
      ),
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        await c.continueWithEmail();
      },
      expect: () => [
        _state(),
        _state(busy: true),
        _state(effect: isA<SignOnToPassword>(), error: null),
      ],
    );

    blocTest<SignOnCubit, SignOnState>(
      'a Google-only account is told so and goes nowhere',
      setUp: () => repo.lookupResult = const Result.ok(
        AccountLookup(
          exists: true,
          hasPassword: false,
          providers: {AuthProvider.google},
        ),
      ),
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        await c.continueWithEmail();
      },
      skip: 2,
      expect: () => [_state(error: AuthError.socialOnly, effect: null)],
    );

    blocTest<SignOnCubit, SignOnState>(
      'a bad email never reaches the server',
      build: build,
      act: (c) async {
        c.emailChanged('nope');
        await c.continueWithEmail();
      },
      skip: 1,
      expect: () => [_state(error: AuthError.invalidEmail)],
      verify: (_) => expect(repo.calls, isEmpty),
    );

    blocTest<SignOnCubit, SignOnState>(
      'offline is reported as offline',
      setUp: () => repo.lookupResult = const Result.err(OfflineFailure()),
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        await c.continueWithEmail();
      },
      skip: 2,
      expect: () => [_state(busy: false, error: AuthError.offline)],
    );

    blocTest<SignOnCubit, SignOnState>(
      'a second tap while busy is ignored',
      setUp: () => repo.lookupResult = const Result.ok(
        AccountLookup(exists: false, hasPassword: false),
      ),
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        // Two taps in the same turn: the second must be dropped.
        await Future.wait([c.continueWithEmail(), c.continueWithEmail()]);
      },
      verify: (_) => expect(repo.calls.length, 1),
    );
  });

  group('log in', () {
    blocTest<SignOnCubit, SignOnState>(
      'success hands the session to the page as an effect',
      setUp: () => repo.logInResult = Result.ok(outcomeWith(AuthGate.none)),
      build: build,
      seed: () => const SignOnState(email: 'ngozi@example.com'),
      act: (c) => c.logIn('Secret!123'),
      expect: () => [
        _state(busy: true),
        _state(busy: false, effect: isA<SignOnSignedIn>()),
      ],
    );

    blocTest<SignOnCubit, SignOnState>(
      'a wrong password (401) is a wrong password',
      setUp: () => repo.logInResult = const Result.err(UnauthorizedFailure()),
      build: build,
      seed: () => const SignOnState(email: 'ngozi@example.com'),
      act: (c) => c.logIn('nope'),
      skip: 1,
      expect: () => [_state(busy: false, error: AuthError.wrongPassword)],
    );

    blocTest<SignOnCubit, SignOnState>(
      'a locked account (403) says locked',
      setUp: () => repo.logInResult = const Result.err(ForbiddenFailure()),
      build: build,
      seed: () => const SignOnState(email: 'ngozi@example.com'),
      act: (c) => c.logIn('x'),
      skip: 1,
      expect: () => [_state(error: AuthError.accountLocked)],
    );

    blocTest<SignOnCubit, SignOnState>(
      'a step the app cannot do (no session) is not a sign-in',
      setUp: () => repo.logInResult = const Result.ok(outcomeNoSession),
      build: build,
      seed: () => const SignOnState(email: 'ngozi@example.com'),
      act: (c) => c.logIn('x'),
      skip: 1,
      expect: () => [_state(error: AuthError.unsupportedStep, effect: null)],
    );

    blocTest<SignOnCubit, SignOnState>(
      'an empty password does nothing',
      build: build,
      act: (c) => c.logIn(''),
      expect: () => <SignOnState>[],
    );
  });

  group('sign up', () {
    Future<void> join(SignOnCubit c, {String phone = '0803 123 4567'}) async {
      c.emailChanged('ngozi@example.com');
      await c.loadTermsVersion();
      c.setTermsAccepted(true);
      await c.signUp(
        firstName: 'Ngozi',
        lastName: 'Okafor',
        phone: phone,
        password: 'Secret!123',
      );
    }

    blocTest<SignOnCubit, SignOnState>(
      'success sends the +234 number and keeps the challenge',
      setUp: () => repo.signUpResult = Result.ok(
        outcomeWith(
          AuthGate.verifyEmail,
          challenge: OtpChallenge(
            expiresAt: DateTime.utc(2026, 11, 21, 10, 10),
            nextSendAt: DateTime.utc(2026, 11, 21, 10),
          ),
        ),
      ),
      build: build,
      act: join,
      verify: (c) {
        expect(repo.calls, contains('signUp:+2348031234567'));
        expect(repo.lastSignUp?.termsVersion, 'terms-test');
        expect(c.state.challenge?.nextSendAt, DateTime.utc(2026, 11, 21, 10));
        expect(c.state.effect, isA<SignOnSignedIn>());
      },
    );

    blocTest<SignOnCubit, SignOnState>(
      'a taken email (409) is reported for the banner',
      setUp: () => repo.signUpResult = const Result.err(
        ConflictFailure('x', 'EMAIL_TAKEN'),
      ),
      build: build,
      act: join,
      verify: (c) => expect(c.state.error, AuthError.emailTaken),
    );

    blocTest<SignOnCubit, SignOnState>(
      'a taken phone (409) is reported for the field',
      setUp: () => repo.signUpResult = const Result.err(
        ConflictFailure('x', 'PHONE_TAKEN'),
      ),
      build: build,
      act: join,
      verify: (c) => expect(c.state.error, AuthError.phoneTaken),
    );

    blocTest<SignOnCubit, SignOnState>(
      'stale terms (409) is named, not shown as a generic error',
      setUp: () => repo.signUpResult = const Result.err(
        ConflictFailure('x', 'AUTH_TERMS_VERSION_STALE'),
      ),
      build: build,
      act: join,
      verify: (c) {
        expect(c.state.error, AuthError.termsStale);
        expect(c.state.termsVersion, isNull);
        expect(c.state.termsAccepted, isFalse);
      },
    );

    blocTest<SignOnCubit, SignOnState>(
      'signup is blocked until the current terms are fetched and accepted',
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        await c.signUp(
          firstName: 'Ngozi',
          lastName: 'Okafor',
          phone: '0803 123 4567',
          password: 'Secret!123',
        );
      },
      verify: (_) => expect(
        repo.calls.where((call) => call.startsWith('signUp:')),
        isEmpty,
      ),
    );

    blocTest<SignOnCubit, SignOnState>(
      'a failed terms request prevents signup and exposes the failure',
      setUp: () => repo.termsVersionResult = const Result.err(OfflineFailure()),
      build: build,
      act: (c) async {
        await c.loadTermsVersion();
        c.setTermsAccepted(true);
        await c.signUp(
          firstName: 'Ngozi',
          lastName: 'Okafor',
          phone: '0803 123 4567',
          password: 'Secret!123',
        );
      },
      verify: (c) {
        expect(c.state.error, AuthError.offline);
        expect(repo.calls.where((call) => call.startsWith('signUp:')), isEmpty);
      },
    );

    blocTest<SignOnCubit, SignOnState>(
      'a common password (422) is reported',
      setUp: () => repo.signUpResult = const Result.err(
        ValidationFailure({}, 'x', 'PASSWORD_COMMON'),
      ),
      build: build,
      act: join,
      verify: (c) => expect(c.state.error, AuthError.passwordCommon),
    );

    blocTest<SignOnCubit, SignOnState>(
      'a number that cannot be Nigerian never reaches the server',
      build: build,
      act: (c) => join(c, phone: '12345'),
      verify: (c) {
        expect(c.state.error, AuthError.phoneInvalid);
        expect(repo.calls.where((call) => call.startsWith('signUp:')), isEmpty);
      },
    );

    blocTest<SignOnCubit, SignOnState>(
      'a weak password never reaches the server',
      build: build,
      act: (c) async {
        c.emailChanged('ngozi@example.com');
        await c.signUp(
          firstName: 'Ngozi',
          lastName: 'Okafor',
          phone: '0803 123 4567',
          password: 'abc',
        );
      },
      verify: (_) =>
          expect(repo.calls.where((call) => call.startsWith('signUp:')), isEmpty),
    );
  });

  group('live password check', () {
    blocTest<SignOnCubit, SignOnState>(
      'length and symbol answer at once, without the server',
      build: build,
      act: (c) => c.passwordChanged('abc'),
      expect: () => [_state()],
      verify: (c) {
        expect(c.state.passwordProblems, {
          PasswordProblem.tooShort,
          PasswordProblem.noSymbol,
        });
        expect(c.state.passwordServerChecked, isFalse);
        expect(repo.calls, isEmpty);
      },
    );

    blocTest<SignOnCubit, SignOnState>(
      'a common password is flagged after a short pause, only the latest wins',
      setUp: () => repo.checkResult = const Result.ok(
        PasswordCheck(ok: false, problems: {PasswordProblem.common}),
      ),
      build: build,
      act: (c) async {
        c.passwordChanged('Password1');
        c.passwordChanged('Password1!');
        await Future<void>.delayed(const Duration(milliseconds: 450));
      },
      verify: (c) {
        expect(c.state.passwordProblems, contains(PasswordProblem.common));
        expect(c.state.passwordServerChecked, isTrue);
        // The first, superseded entry was short a symbol: it never hit the
        // server. Only the settled one did.
        expect(repo.calls.where((x) => x == 'checkPassword').length, 1);
      },
    );
  });

  blocTest<SignOnCubit, SignOnState>(
    'an effect is cleared once the page has handled it',
    build: build,
    seed: () => const SignOnState(effect: SignOnEffect.toJoin()),
    act: (c) => c.effectHandled(),
    expect: () => [_state(effect: null)],
  );
}
