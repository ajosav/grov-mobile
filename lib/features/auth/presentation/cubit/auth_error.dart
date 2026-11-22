import '../../../../core/error/failure.dart';

/// Everything that can go wrong in sign-on, as the screens name it. The cubits
/// map a [Failure] to one of these by the server's `code`, never its message.
enum AuthError() {
  offline,
  timeout,
  server,
  invalidEmail,
  accountLocked,
  accountSuspended,
  emailTaken,
  phoneTaken,
  phoneInvalid,
  codeInvalid,
  codeExpired,
  codeLocked,
  resendTooSoon,

  /// The sign-up ticket expired or was used: verify the email again.
  ticketExpired,
  termsStale,
  phoneAlreadySet,
  unsupportedStep,
  unknown,
}

/// Maps a failure from a sign-on call. A 401 is not a wrong password any more
/// (there are no passwords), so it is [AuthError.unknown].
AuthError authErrorOf(Failure failure) => switch (failure) {
  OfflineFailure() => AuthError.offline,
  TimeoutFailure() => AuthError.timeout,
  ServerFailure() => AuthError.server,
  ForbiddenFailure(:final code) => switch (code) {
    null || 'AUTH_ACCOUNT_LOCKED' => AuthError.accountLocked,
    'ACCOUNT_SUSPENDED' => AuthError.accountSuspended,
    _ => AuthError.unknown,
  },
  ConflictFailure(:final code) => switch (code) {
    'EMAIL_TAKEN' => AuthError.emailTaken,
    'PHONE_TAKEN' => AuthError.phoneTaken,
    'AUTH_TERMS_VERSION_STALE' => AuthError.termsStale,
    'PHONE_ALREADY_SET' => AuthError.phoneAlreadySet,
    _ => AuthError.unknown,
  },
  ValidationFailure(:final code) => switch (code) {
    'PHONE_INVALID' => AuthError.phoneInvalid,
    'OTP_INVALID' => AuthError.codeInvalid,
    'OTP_EXPIRED' => AuthError.codeExpired,
    'OTP_LOCKED' => AuthError.codeLocked,
    'OTP_REGISTRATION_INVALID' => AuthError.ticketExpired,
    _ => AuthError.unknown,
  },
  RateLimitedFailure(:final code) => switch (code) {
    'OTP_RESEND_TOO_SOON' => AuthError.resendTooSoon,
    'AUTH_ACCOUNT_LOCKED' => AuthError.accountLocked,
    _ => AuthError.unknown,
  },
  BadRequestFailure(:final code) =>
    code == 'AUTH_TERMS_VERSION_STALE'
        ? AuthError.termsStale
        : AuthError.unknown,
  _ => AuthError.unknown,
};

/// The server's `nextSendAt` on a too-soon request, if it sent one.
DateTime? nextSendAtOf(Failure failure) => switch (failure) {
  RateLimitedFailure(:final params) when params['nextSendAt'] is String =>
    DateTime.tryParse(params['nextSendAt']! as String),
  _ => null,
};

DateTime? retryAtOf(Failure failure) => switch (failure) {
  RateLimitedFailure(:final params) when params['retryAt'] is String =>
    DateTime.tryParse(params['retryAt']! as String),
  _ => null,
};
