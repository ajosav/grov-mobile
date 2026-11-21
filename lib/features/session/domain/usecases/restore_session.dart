import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/session.dart';
import '../repositories/session_repository.dart';

class const RestoreSession(final SessionRepository _repository)
    implements UseCase<Session?, NoParams> {
  @override
  Future<Result<Session?>> call(NoParams params) => _repository.restore();
}
