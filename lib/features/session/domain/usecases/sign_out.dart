import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/session_repository.dart';

class const SignOut(final SessionRepository _repository)
    implements UseCase<void, NoParams> {
  @override
  Future<Result<void>> call(NoParams params) => _repository.clear();
}
