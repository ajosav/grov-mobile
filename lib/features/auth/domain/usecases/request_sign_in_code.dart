import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/otp_challenge.dart';
import '../repositories/auth_repository.dart';

/// Emails the sign-in code (also used to send a new one).
class const RequestSignInCode(final AuthRepository _repository)
    implements UseCase<OtpChallenge, String> {
  @override
  Future<Result<OtpChallenge>> call(String params) =>
      _repository.requestCode(params);
}
