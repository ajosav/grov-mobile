import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/device_settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [DeviceSettingsTable])
class SettingsDao(super.attachedDatabase)
    extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  static const _rowId = 1;

  Stream<DeviceSettingsRow> watch() => (select(
    deviceSettingsTable,
  )..where((t) => t.id.equals(_rowId))).watchSingle();

  Future<DeviceSettingsRow> read() => (select(
    deviceSettingsTable,
  )..where((t) => t.id.equals(_rowId))).getSingle();

  Future<void> ensureRow() => into(deviceSettingsTable).insert(
    DeviceSettingsTableCompanion.insert(id: const Value(_rowId)),
    mode: InsertMode.insertOrIgnore,
  );

  Future<void> setAppearance(String value) =>
      _update(DeviceSettingsTableCompanion(appearance: Value(value)));

  Future<void> setLowEnd(String value) =>
      _update(DeviceSettingsTableCompanion(lowEnd: Value(value)));

  Future<void> setRememberedEmail(String? value) =>
      _update(DeviceSettingsTableCompanion(rememberedEmail: Value(value)));

  Future<void> _update(DeviceSettingsTableCompanion c) =>
      (update(deviceSettingsTable)..where((t) => t.id.equals(_rowId))).write(c);
}
