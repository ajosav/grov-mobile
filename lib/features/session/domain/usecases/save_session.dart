import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/session.dart';
import '../repositories/session_repository.dart';

/// Persists a session after a successful sign-in.
class const SaveSession(final SessionRepository _repository)
    implements UseCase<void, Session> {
  @override
  Future<Result<void>> call(Session params) => _repository.save(params);
}
