import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_outcome.dart';
import '../repositories/auth_repository.dart';

/// Checks the 6-digit code and clears the email gate.
class const VerifyEmail(final AuthRepository _repository)
    implements UseCase<AuthOutcome, String> {
  @override
  Future<Result<AuthOutcome>> call(String params) =>
      _repository.verifyEmail(params);
}
