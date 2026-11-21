import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/presentation/cubit/auth_error.dart';
import 'package:app_mobile/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

void main() {
  late FakeAuthRepository repo;
  setUp(() => repo = FakeAuthRepository());

  group('forgot password', () {
    final next = DateTime.utc(2026, 11, 21, 10, 0, 30);

    test('a plausible email is sent and the countdown starts', () async {
      repo.forgotResult = Result.ok(next);
      final c = forgotPasswordCubitFor(repo, email: 'ngozi@example.com');
      await c.send();
      expect(c.state.sent, isTrue);
      expect(c.state.nextSendAt, next);
      expect(repo.calls, ['forgot:ngozi@example.com']);
      c.sentHandled();
      expect(c.state.sent, isFalse);
      await c.close();
    });

    test('a bad email is caught before the server', () async {
      final c = forgotPasswordCubitFor(repo);
      c.emailChanged('nope');
      await c.send();
      expect(c.state.error, AuthError.invalidEmail);
      expect(repo.calls, isEmpty);
      await c.close();
    });

    test('too soon keeps the server countdown', () async {
      repo.forgotResult = Result.err(
        RateLimitedFailure('x', 'OTP_RESEND_TOO_SOON', {
          'nextSendAt': next.toIso8601String(),
        }),
      );
      final c = forgotPasswordCubitFor(repo, email: 'ngozi@example.com');
      await c.send();
      expect(c.state.sent, isFalse);
      expect(c.state.nextSendAt, next);
      await c.close();
    });
  });

  group('reset password', () {
    test('a good link opens the form', () async {
      final c = resetPasswordCubitFor(repo);
      await c.load();
      expect(c.state.link, ResetLinkStatus.ready);
      await c.close();
    });

    test('a link the server calls invalid is dead', () async {
      repo.resetCheckResult = const Result.ok(false);
      final c = resetPasswordCubitFor(repo);
      await c.load();
      expect(c.state.link, ResetLinkStatus.dead);
      await c.close();
    });

    test('a mangled link is dead without asking the server', () async {
      final c = resetPasswordCubitFor(repo, token: 'short');
      await c.load();
      expect(c.state.link, ResetLinkStatus.dead);
      expect(repo.calls, isEmpty);
      await c.close();
    });

    test('offline does not kill the link', () async {
      repo.resetCheckResult = const Result.err(OfflineFailure());
      final c = resetPasswordCubitFor(repo);
      await c.load();
      expect(c.state.link, ResetLinkStatus.ready);
      await c.close();
    });

    test('a weak password is not submitted', () async {
      final c = resetPasswordCubitFor(repo);
      await c.submit('abc');
      expect(repo.calls, isEmpty);
      await c.close();
    });

    test('saving signs in', () async {
      repo.resetResult = Result.ok(outcomeWith(AuthGate.none));
      final c = resetPasswordCubitFor(repo);
      await c.submit('Secret!123');
      expect(c.state.signedInSession?.gate, AuthGate.none);
      await c.close();
    });

    test('a link used in the meantime (410) turns dead on submit', () async {
      repo.resetResult = const Result.err(GoneFailure('x', 'RESET_LINK_USED'));
      final c = resetPasswordCubitFor(repo);
      await c.load();
      await c.submit('Secret!123');
      expect(c.state.link, ResetLinkStatus.dead);
      expect(c.state.error, AuthError.linkUsed);
      await c.close();
    });
  });

  group('phone', () {
    test('a good number is sent in +234 form and signs in', () async {
      repo.phoneResult = Result.ok(outcomeWith(AuthGate.none));
      final c = phoneCubitFor(repo);
      await c.submit('803 123 4567');
      expect(repo.calls, ['phone:+2348031234567']);
      expect(c.state.signedInSession, isNotNull);
      await c.close();
    });

    test(
      'a bad number never reaches the server; editing clears the error',
      () async {
        final c = phoneCubitFor(repo);
        await c.submit('123');
        expect(c.state.error, AuthError.phoneInvalid);
        expect(repo.calls, isEmpty);
        c.phoneEdited();
        expect(c.state.error, isNull);
        await c.close();
      },
    );

    test('a number on another account is reported', () async {
      repo.phoneResult = const Result.err(ConflictFailure('x', 'PHONE_TAKEN'));
      final c = phoneCubitFor(repo);
      await c.submit('803 123 4567');
      expect(c.state.error, AuthError.phoneTaken);
      await c.close();
    });
  });

  test('every failure maps to a screen error, and none to a crash', () {
    expect(authErrorOf(const OfflineFailure()), AuthError.offline);
    expect(authErrorOf(const TimeoutFailure()), AuthError.timeout);
    expect(authErrorOf(const ServerFailure()), AuthError.server);
    expect(
      authErrorOf(const ConflictFailure('x', 'PHONE_ALREADY_SET')),
      AuthError.phoneAlreadySet,
    );
    expect(
      authErrorOf(const ConflictFailure('x', 'EMAIL_ALREADY_VERIFIED')),
      AuthError.emailAlreadyVerified,
    );
    expect(
      authErrorOf(const ConflictFailure('x', 'EMAIL_CHANGE_NOT_STARTED')),
      AuthError.emailChangeNotStarted,
    );
    expect(
      authErrorOf(const ConflictFailure('x', 'NEW_CODE')),
      AuthError.unknown,
    );
    expect(authErrorOf(const UnknownFailure()), AuthError.unknown);
    expect(authErrorOf(const NotFoundFailure()), AuthError.unknown);
    expect(authErrorOf(const CacheFailure()), AuthError.unknown);
    expect(
      authErrorOf(const BadRequestFailure('x', 'AUTH_TERMS_VERSION_STALE')),
      AuthError.termsStale,
    );
    expect(
      authErrorOf(const RateLimitedFailure('x', 'AUTH_ACCOUNT_LOCKED')),
      AuthError.accountLocked,
    );
    expect(
      authErrorOf(const GoneFailure('x', 'RESET_LINK_EXPIRED')),
      AuthError.linkExpired,
    );
    expect(nextSendAtOf(const OfflineFailure()), isNull);
  });
}
