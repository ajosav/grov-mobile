import '../../../../core/connectivity/connectivity_service.dart';
import '../../../../core/database/daos/cache_dao.dart';
import '../../../../core/error/guard.dart';
import '../../../../core/error/result.dart';
import '../../domain/repositories/sync_repository.dart';

class const SyncRepositoryImpl(
  final ConnectivityService _connectivity,
  final CacheDao _cache,
) implements SyncRepository {
  @override
  Future<Result<bool>> isOnline() => guardLocal(() => _connectivity.isOnline);

  @override
  Stream<Result<bool>> watchOnline() =>
      guardStream(_connectivity.onlineChanges);

  @override
  Stream<Result<DateTime?>> watchLastSyncedAt() =>
      guardStream(_cache.watchLastSyncedAt());
}
