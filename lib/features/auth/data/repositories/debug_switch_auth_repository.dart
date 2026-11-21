import '../../../../core/config/debug_config.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/account_lookup.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/new_account.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/entities/password_check.dart';
import '../../domain/repositories/auth_repository.dart';

/// DEBUG BUILDS ONLY. Sends each call to the sample repository or the real one,
/// depending on [DebugConfig.sampleData] at the moment of the call. Release
/// builds register the real repository directly and never reference this.
class const DebugSwitchAuthRepository({
  required final AuthRepository _real,
  required final AuthRepository _sample,
}) implements AuthRepository {
  AuthRepository get _active => DebugConfig.sampleData.value ? _sample : _real;

  @override
  Future<Result<AccountLookup>> lookup(String email) => _active.lookup(email);

  @override
  Future<Result<PasswordCheck>> checkPassword(
    String password, {
    String? email,
  }) => _active.checkPassword(password, email: email);

  @override
  Future<Result<AuthOutcome>> signUp(NewAccount account) =>
      _active.signUp(account);

  @override
  Future<Result<AuthOutcome>> logIn(String email, String password) =>
      _active.logIn(email, password);

  @override
  Future<Result<AuthOutcome>> verifyEmail(String code) =>
      _active.verifyEmail(code);

  @override
  Future<Result<OtpChallenge>> resendEmailCode() => _active.resendEmailCode();

  @override
  Future<Result<OtpChallenge>> changeEmailAddress(String newEmail) =>
      _active.changeEmailAddress(newEmail);

  @override
  Future<Result<DateTime>> requestPasswordReset(String email) =>
      _active.requestPasswordReset(email);

  @override
  Future<Result<bool>> checkResetLink(String token) =>
      _active.checkResetLink(token);

  @override
  Future<Result<AuthOutcome>> resetPassword(String token, String password) =>
      _active.resetPassword(token, password);

  @override
  Future<Result<AuthOutcome>> completePhone(String phone) =>
      _active.completePhone(phone);
}
