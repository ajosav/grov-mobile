import '../../../../core/database/app_database.dart';
import '../../domain/entities/device_settings.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract final class DeviceSettingsMapper {
  static DeviceSettings toEntity(DeviceSettingsRow row) => DeviceSettings(
    appearance:
        AppearanceMode.values.asNameMap()[row.appearance] ??
        AppearanceMode.system,
    lowEnd:
        LowEndPreference.values.asNameMap()[row.lowEnd] ??
        LowEndPreference.auto,
    rememberedEmail: row.rememberedEmail,
  );
}
