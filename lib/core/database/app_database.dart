import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/cache_dao.dart';
import 'daos/drafts_dao.dart';
import 'daos/settings_dao.dart';
import 'tables/cache_entries_table.dart';
import 'tables/device_settings_table.dart';
import 'tables/drafts_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [DeviceSettingsTable, DraftsTable, CacheEntriesTable],
  daos: [SettingsDao, DraftsDao, CacheDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openOnDisk());

  /// In-memory database for tests.
  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await settingsDao.ensureRow();
    },
    // Add `onUpgrade` with stepByStep(...) when schemaVersion goes above 1.
  );
}

QueryExecutor _openOnDisk() => LazyDatabase(() async {
  final dir = await getApplicationSupportDirectory();
  final file = File(p.join(dir.path, 'app.sqlite'));
  return NativeDatabase.createInBackground(
    file,
    setup: (db) {
      db.execute('PRAGMA journal_mode = WAL');
      db.execute('PRAGMA synchronous = NORMAL');
    },
  );
});
