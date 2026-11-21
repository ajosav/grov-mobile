import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../session/domain/entities/auth_gate.dart';
import '../../../session/domain/entities/session.dart';
import '../../domain/entities/account_lookup.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/auth_provider.dart';
import '../../domain/entities/new_account.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/entities/password_check.dart';
import '../../domain/entities/password_problem.dart';
import '../../domain/repositories/auth_repository.dart';

/// DEBUG BUILDS ONLY. Scripted sample answers for every sign-on call, so each
/// screen and error state can be reached with no backend. The rules (what to
/// type to get which screen) are listed in the debug panel on Welcome.
///
/// It keeps no state between calls and stores nothing.
class DebugAuthRepository({
  /// A little delay so loading states are visible. Tests pass zero.
  final Duration latency = const Duration(milliseconds: 350),
  final DateTime Function() now = DateTime.now,
}) implements AuthRepository {
  /// The only email the code and phone screens know after a sign-up.
  String _email = 'sample@example.com';

  Future<Result<T>> _ok<T>(T value) async {
    await Future<void>.delayed(latency);
    return Result.ok(value);
  }

  Future<Result<T>> _err<T>(Failure failure) async {
    await Future<void>.delayed(latency);
    return Result.err(failure);
  }

  Session _session(AuthGate gate) => Session(
    accessToken: 'sample-access',
    refreshToken: 'sample-refresh-token-000000',
    expiresAt: now().add(const Duration(days: 1)),
    gate: gate,
    email: _email,
  );

  OtpChallenge _challenge(int seconds) => OtpChallenge(
    expiresAt: now().add(const Duration(minutes: 10)),
    nextSendAt: now().add(Duration(seconds: seconds)),
  );

  bool _has(String text, String part) => text.toLowerCase().contains(part);

  @override
  Future<Result<AccountLookup>> lookup(String email) {
    _email = email;
    if (_has(email, 'google')) {
      return _ok(
        const AccountLookup(
          exists: true,
          hasPassword: false,
          providers: {AuthProvider.google},
        ),
      );
    }
    final exists =
        _has(email, 'known') ||
        _has(email, 'exists') ||
        _has(email, 'login') ||
        _has(email, 'locked') ||
        _has(email, 'unverified');
    return _ok(AccountLookup(exists: exists, hasPassword: exists));
  }

  @override
  Future<Result<PasswordCheck>> checkPassword(
    String password, {
    String? email,
  }) {
    final common = _has(password, 'password') || password.contains('12345678');
    return _ok(
      common
          ? const PasswordCheck(ok: false, problems: {PasswordProblem.common})
          : const PasswordCheck(ok: true),
    );
  }

  @override
  Future<Result<AuthOutcome>> signUp(NewAccount account) {
    _email = account.email;
    if (_has(account.email, 'taken')) {
      return _err(const ConflictFailure('sample', 'EMAIL_TAKEN'));
    }
    if (account.phone.endsWith('0000')) {
      return _err(const ConflictFailure('sample', 'PHONE_TAKEN'));
    }
    return _ok(
      AuthOutcome(
        session: _session(AuthGate.verifyEmail),
        challenge: _challenge(30),
        firstName: account.firstName,
      ),
    );
  }

  @override
  Future<Result<AuthOutcome>> logIn(String email, String password) {
    _email = email;
    if (password == 'wrong') {
      return _err(const UnauthorizedFailure());
    }
    if (_has(email, 'locked')) {
      return _err(const ForbiddenFailure('sample'));
    }
    final unverified = _has(email, 'unverified');
    return _ok(
      AuthOutcome(
        session: _session(unverified ? AuthGate.verifyEmail : AuthGate.none),
        challenge: unverified ? _challenge(30) : null,
        firstName: 'Sample',
      ),
    );
  }

  @override
  Future<Result<AuthOutcome>> verifyEmail(String code) => switch (code) {
    '111111' => _err(const ValidationFailure({}, 'sample', 'OTP_INVALID')),
    '222222' => _err(const ValidationFailure({}, 'sample', 'OTP_EXPIRED')),
    '000000' => _err(const ValidationFailure({}, 'sample', 'OTP_LOCKED')),
    _ => _ok(AuthOutcome(session: _session(AuthGate.none))),
  };

  @override
  Future<Result<OtpChallenge>> resendEmailCode() => _ok(_challenge(60));

  @override
  Future<Result<OtpChallenge>> changeEmailAddress(String newEmail) {
    if (_has(newEmail, 'taken')) {
      return _err(const ConflictFailure('sample', 'EMAIL_TAKEN'));
    }
    _email = newEmail;
    return _ok(_challenge(30));
  }

  @override
  Future<Result<DateTime>> requestPasswordReset(String email) =>
      _ok(now().add(const Duration(seconds: 45)));

  @override
  Future<Result<bool>> checkResetLink(String token) =>
      _ok(!_has(token, 'expired'));

  @override
  Future<Result<AuthOutcome>> resetPassword(String token, String password) {
    if (_has(token, 'used')) {
      return _err(const GoneFailure('sample', 'RESET_LINK_USED'));
    }
    return _ok(AuthOutcome(session: _session(AuthGate.none)));
  }

  @override
  Future<Result<AuthOutcome>> completePhone(String phone) {
    if (phone.endsWith('0000')) {
      return _err(const ConflictFailure('sample', 'PHONE_TAKEN'));
    }
    return _ok(AuthOutcome(session: _session(AuthGate.none)));
  }
}
