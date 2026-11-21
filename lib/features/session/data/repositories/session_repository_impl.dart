import '../../../../core/error/failure.dart';
import '../../../../core/error/guard.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_data_source.dart';
import '../datasources/session_remote_data_source.dart';
import '../models/session_model.dart';

class const SessionRepositoryImpl({
  required final SessionLocalDataSource _local,
  required final SessionRemoteDataSource _remote,
}) implements SessionRepository {
  @override
  Future<Result<Session?>> restore() =>
      guardLocal(() async => (await _local.read())?.toEntity());

  @override
  Future<Result<void>> save(Session session) =>
      guardLocal(() => _local.write(SessionModel.fromEntity(session)));

  @override
  Future<Result<void>> clear() => guardLocal(_local.delete);

  @override
  Future<Result<Session?>> refresh(Session current) async {
    final result = await guardApi(() => _remote.refresh(current.refreshToken));
    return switch (result) {
      Ok(:final value) => await _persist(value, current),
      // 401/403 from the refresh call means the session is gone.
      Err(failure: UnauthorizedFailure() || ForbiddenFailure()) =>
        const Result.ok(null),
      Err(:final failure) => Result.err(failure),
    };
  }

  Future<Result<Session?>> _persist(
    SessionModel? model,
    Session current,
  ) async {
    if (model == null) {
      return const Result.ok(null);
    }
    // The server recomputes gates on refresh but does not return them here,
    // so the session keeps the gate it had.
    final session = model.toEntity().copyWith(
      gate: current.gate,
      email: current.email,
    );
    final saved = await save(session);
    return switch (saved) {
      Ok() => Result.ok(session),
      Err(:final failure) => Result.err(failure),
    };
  }
}
