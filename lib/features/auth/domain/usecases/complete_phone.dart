import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_outcome.dart';
import '../repositories/auth_repository.dart';

/// Adds the phone after a Google or Apple sign-up.
class const CompletePhone(final AuthRepository _repository)
    implements UseCase<AuthOutcome, String> {
  @override
  Future<Result<AuthOutcome>> call(String params) =>
      _repository.completePhone(params);
}
