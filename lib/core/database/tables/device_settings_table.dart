import 'package:drift/drift.dart';

/// "On this phone" settings. Single row (id = 1). Survives logout.
@DataClassName('DeviceSettingsRow')
class DeviceSettingsTable() extends Table {
  @override
  String get tableName => 'device_settings';

  IntColumn get id => integer()();
  TextColumn get appearance => text().withDefault(const Constant('system'))();
  TextColumn get lowEnd => text().withDefault(const Constant('auto'))();
  TextColumn get rememberedEmail => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
