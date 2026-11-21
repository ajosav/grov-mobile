import 'package:drift/drift.dart';

/// Server responses worth keeping for offline use (catalogue, plan,
/// household). [syncedAt] drives the "last synced" line.
@DataClassName('CacheEntryRow')
class CacheEntriesTable() extends Table {
  @override
  String get tableName => 'cache_entries';

  TextColumn get key => text()();
  TextColumn get payload => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
