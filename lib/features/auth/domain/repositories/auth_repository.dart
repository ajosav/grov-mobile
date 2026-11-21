import '../../../../core/error/result.dart';
import '../entities/account_lookup.dart';
import '../entities/auth_outcome.dart';
import '../entities/new_account.dart';
import '../entities/otp_challenge.dart';
import '../entities/password_check.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class AuthRepository {
  Future<Result<AccountLookup>> lookup(String email);

  Future<Result<PasswordCheck>> checkPassword(String password, {String? email});

  Future<Result<String>> getTermsVersion();

  Future<Result<AuthOutcome>> signUp(NewAccount account);

  Future<Result<AuthOutcome>> logIn(String email, String password);

  /// Needs the gated session's token.
  Future<Result<AuthOutcome>> verifyEmail(String code);

  Future<Result<OtpChallenge>> resendEmailCode();

  Future<Result<OtpChallenge>> changeEmailAddress(String newEmail);

  /// Always accepted by the server; returns when another link may be sent.
  Future<Result<DateTime>> requestPasswordReset(String email);

  Future<Result<bool>> checkResetLink(String token);

  Future<Result<AuthOutcome>> resetPassword(String token, String password);

  Future<Result<AuthOutcome>> completePhone(String phone);
}
