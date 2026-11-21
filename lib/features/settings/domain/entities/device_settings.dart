import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_settings.freezed.dart';

enum AppearanceMode() {
  system,
  light,
  dark,
}

/// Low-end mode: drops blur and theme animation, caps the image cache.
enum LowEndPreference() {
  auto,
  on,
  off,
}

/// "On this phone" settings. Separate from account preferences: a theme
/// switch must not write the household, and logout must not reset these.
@freezed
abstract class DeviceSettings with _$DeviceSettings {
  const factory DeviceSettings({
    @Default(AppearanceMode.system) AppearanceMode appearance,
    @Default(LowEndPreference.auto) LowEndPreference lowEnd,
    String? rememberedEmail,
  }) = _DeviceSettings;
}
