import '../../../../core/error/failure.dart';

/// Everything that can go wrong in sign-on, as the screens name it. The cubits
/// map a [Failure] to one of these by the server's `code`, never its message.
enum AuthError() {
  offline,
  timeout,
  server,
  invalidEmail,
  socialOnly,
  wrongPassword,
  accountLocked,
  emailTaken,
  phoneTaken,
  phoneInvalid,
  passwordCommon,
  passwordWeak,
  codeInvalid,
  codeExpired,
  codeLocked,
  resendTooSoon,
  linkExpired,
  linkUsed,
  termsStale,
  unsupportedStep,
  unknown,
}

/// Maps a failure from a sign-on call. A 401 here is a wrong password: only
/// the log-in call can return one, and it carries no `code` to branch on.
AuthError authErrorOf(Failure failure) => switch (failure) {
  OfflineFailure() => AuthError.offline,
  TimeoutFailure() => AuthError.timeout,
  ServerFailure() => AuthError.server,
  UnauthorizedFailure() => AuthError.wrongPassword,
  ForbiddenFailure() => AuthError.accountLocked,
  ConflictFailure(:final code) => switch (code) {
    'EMAIL_TAKEN' => AuthError.emailTaken,
    'PHONE_TAKEN' => AuthError.phoneTaken,
    _ => AuthError.unknown,
  },
  ValidationFailure(:final code) => switch (code) {
    'PASSWORD_COMMON' => AuthError.passwordCommon,
    'PASSWORD_WEAK' => AuthError.passwordWeak,
    'PHONE_INVALID' => AuthError.phoneInvalid,
    'OTP_INVALID' => AuthError.codeInvalid,
    'OTP_EXPIRED' => AuthError.codeExpired,
    'OTP_LOCKED' => AuthError.codeLocked,
    _ => AuthError.unknown,
  },
  RateLimitedFailure(:final code) => switch (code) {
    'OTP_RESEND_TOO_SOON' => AuthError.resendTooSoon,
    'AUTH_ACCOUNT_LOCKED' => AuthError.accountLocked,
    _ => AuthError.unknown,
  },
  GoneFailure(:final code) =>
    code == 'RESET_LINK_USED' ? AuthError.linkUsed : AuthError.linkExpired,
  BadRequestFailure(:final code) =>
    code == 'AUTH_TERMS_VERSION_STALE'
        ? AuthError.termsStale
        : AuthError.unknown,
  _ => AuthError.unknown,
};

/// The server's `nextSendAt` on a too-soon resend, if it sent one.
DateTime? nextSendAtOf(Failure failure) => switch (failure) {
  RateLimitedFailure(:final params) when params['nextSendAt'] is String =>
    DateTime.tryParse(params['nextSendAt']! as String),
  _ => null,
};
