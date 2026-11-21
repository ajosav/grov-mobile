import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/otp_challenge.dart';
import '../repositories/auth_repository.dart';

/// Fixes a mistyped email before it is verified.
class const ChangeEmailAddress(final AuthRepository _repository)
    implements UseCase<OtpChallenge, String> {
  @override
  Future<Result<OtpChallenge>> call(String params) =>
      _repository.changeEmailAddress(params);
}
