// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DeviceSettingsTableTable get deviceSettingsTable =>
      attachedDatabase.deviceSettingsTable;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$DeviceSettingsTableTableTableManager get deviceSettingsTable =>
      $$DeviceSettingsTableTableTableManager(
        _db.attachedDatabase,
        _db.deviceSettingsTable,
      );
}
