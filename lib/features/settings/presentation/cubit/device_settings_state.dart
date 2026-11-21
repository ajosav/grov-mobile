import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/device_settings.dart';

part 'device_settings_state.freezed.dart';

@freezed
abstract class const DeviceSettingsState._() with _$DeviceSettingsState {
  const factory DeviceSettingsState({
    @Default(DeviceSettings()) DeviceSettings settings,

    /// Android reports a low-RAM device.
    @Default(false) bool lowRamDevice,

    /// False until the first read from Drift. The app renders defaults (system
    /// theme, blur per device) until then, so the first frame never waits.
    @Default(false) bool loaded,
  }) = _DeviceSettingsState;

  bool get effectiveLowEnd => switch (settings.lowEnd) {
    LowEndPreference.on => true,
    LowEndPreference.off => false,
    LowEndPreference.auto => lowRamDevice,
  };
}
