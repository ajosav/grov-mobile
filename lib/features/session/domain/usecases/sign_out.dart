import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/session_repository.dart';

/// Ends the session. The param is whether to tell the server first (`true`),
/// or only clear this device (`false`, for a session the server already ended).
/// The server call is best-effort: offline or a server error never keeps
/// someone signed in.
class const SignOut(final SessionRepository _repository)
    implements UseCase<void, bool> {
  @override
  Future<Result<void>> call(bool revoke) async {
    if (revoke) {
      await _repository.revoke();
    }
    return _repository.clear();
  }
}
