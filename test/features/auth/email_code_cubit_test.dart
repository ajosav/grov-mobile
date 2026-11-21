import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/domain/entities/otp_challenge.dart';
import 'package:app_mobile/features/auth/presentation/cubit/auth_error.dart';
import 'package:app_mobile/features/auth/presentation/cubit/email_code_state.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

void main() {
  late FakeAuthRepository repo;
  setUp(() => repo = FakeAuthRepository());

  final next = DateTime.utc(2026, 11, 21, 10, 1);
  OtpChallenge challenge() => OtpChallenge(
    expiresAt: next.add(const Duration(minutes: 9)),
    nextSendAt: next,
  );

  test('typing keeps digits only and stops at six', () async {
    repo.verifyResult = Result.ok(outcomeWith(AuthGate.none));
    final c = emailCodeCubitFor(repo);
    c.codeChanged('4a2-9');
    expect(c.state.code, '429');
    expect(repo.calls, isEmpty, reason: 'not six digits yet');
    c.codeChanged('4291078899');
    expect(c.state.code, '429107');
    await c.close();
  });

  test('the sixth digit submits by itself and the code is accepted', () async {
    repo.verifyResult = Result.ok(outcomeWith(AuthGate.none));
    final c = emailCodeCubitFor(repo);
    c.codeChanged('429107');
    await Future<void>.delayed(Duration.zero);
    expect(repo.calls, ['verifyEmail:429107']);
    expect(c.state.status, EmailCodeStatus.accepted);
    expect(c.state.verifiedSession?.gate, AuthGate.none);
    await c.close();
  });

  test('a wrong code stays editable and editing clears the error', () async {
    repo.verifyResult = const Result.err(
      ValidationFailure({}, 'x', 'OTP_INVALID'),
    );
    final c = emailCodeCubitFor(repo);
    c.codeChanged('000000');
    await Future<void>.delayed(Duration.zero);
    expect(c.state.status, EmailCodeStatus.entering);
    expect(c.state.error, AuthError.codeInvalid);
    c.codeChanged('00000');
    expect(c.state.error, isNull);
    await c.close();
  });

  test(
    'too many wrong tries locks the boxes until a new code is sent',
    () async {
      repo.verifyResult = const Result.err(
        ValidationFailure({}, 'x', 'OTP_LOCKED'),
      );
      final c = emailCodeCubitFor(repo);
      c.codeChanged('000000');
      await Future<void>.delayed(Duration.zero);
      expect(c.state.status, EmailCodeStatus.locked);
      c.codeChanged('111111');
      expect(c.state.code, '000000', reason: 'locked boxes ignore typing');

      repo.resendResult = Result.ok(challenge());
      await c.resend();
      expect(c.state.status, EmailCodeStatus.entering);
      expect(c.state.code, isEmpty);
      expect(c.state.nextSendAt, next);
      await c.close();
    },
  );

  test('an expired code is reported, not locked', () async {
    repo.verifyResult = const Result.err(
      ValidationFailure({}, 'x', 'OTP_EXPIRED'),
    );
    final c = emailCodeCubitFor(repo);
    c.codeChanged('123456');
    await Future<void>.delayed(Duration.zero);
    expect(c.state.error, AuthError.codeExpired);
    expect(c.state.status, EmailCodeStatus.entering);
    await c.close();
  });

  test('a code that clears but gives no session is not accepted', () async {
    repo.verifyResult = const Result.ok(outcomeNoSession);
    final c = emailCodeCubitFor(repo);
    c.codeChanged('123456');
    await Future<void>.delayed(Duration.zero);
    expect(c.state.status, EmailCodeStatus.entering);
    expect(c.state.error, AuthError.unsupportedStep);
    await c.close();
  });

  group('resend', () {
    test('success starts a new countdown and clears the boxes', () async {
      repo.resendResult = Result.ok(challenge());
      final c = emailCodeCubitFor(repo);
      await c.resend();
      expect(c.state.nextSendAt, next);
      expect(c.state.resending, isFalse);
      await c.close();
    });

    test('too soon: the countdown follows the server, not our guess', () async {
      repo.resendResult = Result.err(
        RateLimitedFailure('x', 'OTP_RESEND_TOO_SOON', {
          'nextSendAt': next.toIso8601String(),
        }),
      );
      final c = emailCodeCubitFor(repo, nextSendAt: DateTime.utc(2020));
      await c.resend();
      expect(c.state.nextSendAt, next);
      expect(c.state.error, AuthError.resendTooSoon);
      await c.close();
    });

    test('a second tap while one is in flight is ignored', () async {
      repo.resendResult = Result.ok(challenge());
      final c = emailCodeCubitFor(repo);
      await Future.wait([c.resend(), c.resend()]);
      expect(repo.calls.where((x) => x == 'resend').length, 1);
      await c.close();
    });
  });

  group('change email', () {
    test('success swaps the address and restarts the code', () async {
      repo.changeEmailResult = Result.ok(challenge());
      final c = emailCodeCubitFor(repo);
      c.codeChanged('123');
      final failure = await c.changeEmail(' fixed@example.com ');
      expect(failure, isNull);
      expect(c.state.email, 'fixed@example.com');
      expect(c.state.code, isEmpty);
      expect(c.state.nextSendAt, next);
      await c.close();
    });

    test('failure is handed back and the address stays', () async {
      repo.changeEmailResult = const Result.err(
        ConflictFailure('x', 'EMAIL_TAKEN'),
      );
      final c = emailCodeCubitFor(repo);
      final failure = await c.changeEmail('taken@example.com');
      expect(failure, isA<ConflictFailure>());
      expect(c.state.email, 'ngozi@example.com');
      await c.close();
    });
  });
}
