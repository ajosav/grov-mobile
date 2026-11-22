import '../../../../core/error/result.dart';
import '../entities/auth_outcome.dart';
import '../entities/code_verification.dart';
import '../entities/new_profile.dart';
import '../entities/otp_challenge.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class AuthRepository {
  Future<Result<String>> getTermsVersion();

  /// Emails a 6-digit code. The answer is the same for a new and an existing
  /// address; another may be asked for after `nextSendAt`.
  Future<Result<OtpChallenge>> requestCode(String email);

  Future<Result<CodeVerification>> verifyCode(String email, String code);

  /// Creates the account for a verified new address and signs it in.
  Future<Result<AuthOutcome>> completeProfile(NewProfile profile);

  /// Needs the gated session's token.
  Future<Result<AuthOutcome>> completePhone(String phone);
}
