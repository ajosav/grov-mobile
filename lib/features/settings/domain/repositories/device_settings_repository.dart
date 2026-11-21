import '../../../../core/error/result.dart';
import '../entities/device_settings.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class DeviceSettingsRepository {
  Stream<Result<DeviceSettings>> watch();
  Future<Result<void>> setAppearance(AppearanceMode mode);
  Future<Result<void>> setLowEnd(LowEndPreference preference);
  Future<Result<void>> setRememberedEmail(String? email);

  /// True when the OS reports a low-RAM device (about 2 GB or less).
  Future<Result<bool>> isLowRamDevice();
}
