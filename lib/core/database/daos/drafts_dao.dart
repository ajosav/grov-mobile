import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/drafts_table.dart';

part 'drafts_dao.g.dart';

@DriftAccessor(tables: [DraftsTable])
class DraftsDao(super.attachedDatabase)
    extends DatabaseAccessor<AppDatabase>
    with _$DraftsDaoMixin {
  Future<DraftRow?> find(String key) =>
      (select(draftsTable)..where((t) => t.key.equals(key))).getSingleOrNull();

  Future<void> upsert(String key, String payload, DateTime now) =>
      into(draftsTable).insertOnConflictUpdate(
        DraftsTableCompanion.insert(key: key, payload: payload, updatedAt: now),
      );

  Future<int> remove(String key) =>
      (delete(draftsTable)..where((t) => t.key.equals(key))).go();

  Future<int> clearAll() => delete(draftsTable).go();
}
