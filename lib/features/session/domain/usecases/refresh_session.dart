import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/session.dart';
import '../repositories/session_repository.dart';

/// Rotates the token pair. `Ok(null)` means the session was revoked.
class const RefreshSession(final SessionRepository _repository)
    implements UseCase<Session?, Session> {
  @override
  Future<Result<Session?>> call(Session params) => _repository.refresh(params);
}
