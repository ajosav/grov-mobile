import '../../../../core/error/result.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class SyncRepository {
  Future<Result<bool>> isOnline();
  Stream<Result<bool>> watchOnline();

  /// Latest successful sync across cached resources, or null if never synced.
  Stream<Result<DateTime?>> watchLastSyncedAt();
}
