import 'package:drift/drift.dart';

/// Resume drafts: route, step and non-secret fields. Never passwords, OTPs,
/// identity tokens or card data.
@DataClassName('DraftRow')
class DraftsTable() extends Table {
  @override
  String get tableName => 'drafts';

  TextColumn get key => text()();
  TextColumn get payload => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
