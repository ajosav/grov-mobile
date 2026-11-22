import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/domain/entities/code_verification.dart';
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

  test('typing keeps digits only and stops at six', () async {
    repo.verifyResult = Result.ok(signedInWith(AuthGate.none));
    final c = emailCodeCubitFor(repo);
    c.codeChanged('4a2-9');
    expect(c.state.code, '429');
    expect(repo.calls, isEmpty, reason: 'not six digits yet');
    c.codeChanged('4291078899');
    expect(c.state.code, '429107');
    await c.close();
  });

  test('the sixth digit submits by itself; an account is signed in', () async {
    repo.verifyResult = Result.ok(signedInWith(AuthGate.none));
    final c = emailCodeCubitFor(repo);
    c.codeChanged('429107');
    await Future<void>.delayed(Duration.zero);
    expect(repo.calls, ['verifyCode:ngozi@example.com:429107']);
    expect(c.state.status, EmailCodeStatus.accepted);
    expect(c.state.verifiedSession?.gate, AuthGate.none);
    expect(c.state.profileTicket, isNull);
    await c.close();
  });

  test('a code for a new address hands over the profile ticket', () async {
    repo.verifyResult = Result.ok(profileRequired());
    final c = emailCodeCubitFor(repo);
    c.codeChanged('429107');
    await Future<void>.delayed(Duration.zero);
    expect(c.state.status, EmailCodeStatus.accepted);
    expect(c.state.profileTicket?.ticket, 'ticket-of-a-new-address');
    expect(c.state.verifiedSession, isNull);
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

  test('too many wrong tries locks the boxes until a new code is sent', () async {
    repo.verifyResult = const Result.err(
      ValidationFailure({}, 'x', 'OTP_LOCKED'),
    );
    final c = emailCodeCubitFor(repo);
    c.codeChanged('000000');
    await Future<void>.delayed(Duration.zero);
    expect(c.state.status, EmailCodeStatus.locked);
    c.codeChanged('111111');
    expect(c.state.code, '000000', reason: 'locked boxes ignore typing');

    repo.requestCodeResult = Result.ok(challengeAt(next));
    await c.resend();
    expect(c.state.status, EmailCodeStatus.entering);
    expect(c.state.code, isEmpty);
    expect(c.state.nextSendAt, next);
    await c.close();
  });

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
    repo.verifyResult = const Result.ok(
      CodeVerification.signedIn(outcomeNoSession),
    );
    final c = emailCodeCubitFor(repo);
    c.codeChanged('123456');
    await Future<void>.delayed(Duration.zero);
    expect(c.state.status, EmailCodeStatus.entering);
    expect(c.state.error, AuthError.unsupportedStep);
    await c.close();
  });

  group('resend', () {
    test('success starts a new countdown and clears the boxes', () async {
      repo.requestCodeResult = Result.ok(challengeAt(next));
      final c = emailCodeCubitFor(repo);
      await c.resend();
      expect(repo.calls, ['requestCode:ngozi@example.com']);
      expect(c.state.nextSendAt, next);
      expect(c.state.resending, isFalse);
      await c.close();
    });

    test('too soon: the countdown follows the server, not our guess', () async {
      repo.requestCodeResult = Result.err(
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
      repo.requestCodeResult = Result.ok(challengeAt(next));
      final c = emailCodeCubitFor(repo);
      await Future.wait([c.resend(), c.resend()]);
      expect(
        repo.calls.where((x) => x.startsWith('requestCode')).length,
        1,
      );
      await c.close();
    });
  });
}
