import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/otp_challenge.dart';
import '../repositories/auth_repository.dart';

/// Sends a new code (the server backs off 30 s, 60 s, 120 s).
class const ResendEmailCode(final AuthRepository _repository)
    implements UseCase<OtpChallenge, NoParams> {
  @override
  Future<Result<OtpChallenge>> call(NoParams params) =>
      _repository.resendEmailCode();
}
