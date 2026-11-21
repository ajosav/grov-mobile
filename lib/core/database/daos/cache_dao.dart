import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/cache_entries_table.dart';

part 'cache_dao.g.dart';

@DriftAccessor(tables: [CacheEntriesTable])
class CacheDao(super.attachedDatabase)
    extends DatabaseAccessor<AppDatabase>
    with _$CacheDaoMixin {
  Future<CacheEntryRow?> find(String key) => (select(
    cacheEntriesTable,
  )..where((t) => t.key.equals(key))).getSingleOrNull();

  Stream<CacheEntryRow?> watch(String key) => (select(
    cacheEntriesTable,
  )..where((t) => t.key.equals(key))).watchSingleOrNull();

  /// Most recent successful sync across all resources, for "last synced".
  Stream<DateTime?> watchLastSyncedAt() {
    final max = cacheEntriesTable.syncedAt.max();
    return (selectOnly(
      cacheEntriesTable,
    )..addColumns([max])).watchSingle().map((r) => r.read(max));
  }

  Future<void> put(String key, String payload, DateTime now) =>
      into(cacheEntriesTable).insertOnConflictUpdate(
        CacheEntriesTableCompanion.insert(
          key: key,
          payload: payload,
          syncedAt: now,
        ),
      );

  Future<int> clearAll() => delete(cacheEntriesTable).go();
}
