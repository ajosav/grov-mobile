import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Emails a reset link. Returns when another may be sent.
class const RequestPasswordReset(final AuthRepository _repository)
    implements UseCase<DateTime, String> {
  @override
  Future<Result<DateTime>> call(String params) =>
      _repository.requestPasswordReset(params);
}
