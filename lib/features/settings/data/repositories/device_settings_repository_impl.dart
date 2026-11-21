import '../../../../core/database/daos/settings_dao.dart';
import '../../../../core/error/guard.dart';
import '../../../../core/error/result.dart';
import '../../../../core/platform/device_capabilities.dart';
import '../../domain/entities/device_settings.dart';
import '../../domain/repositories/device_settings_repository.dart';
import '../mappers/device_settings_mapper.dart';

class const DeviceSettingsRepositoryImpl(
  final SettingsDao _dao,
  final DeviceCapabilities _capabilities,
) implements DeviceSettingsRepository {
  @override
  Stream<Result<DeviceSettings>> watch() =>
      guardStream(_dao.watch().map(DeviceSettingsMapper.toEntity));

  @override
  Future<Result<void>> setAppearance(AppearanceMode mode) =>
      guardLocal(() => _dao.setAppearance(mode.name));

  @override
  Future<Result<void>> setLowEnd(LowEndPreference preference) =>
      guardLocal(() => _dao.setLowEnd(preference.name));

  @override
  Future<Result<void>> setRememberedEmail(String? email) =>
      guardLocal(() => _dao.setRememberedEmail(email));

  @override
  Future<Result<bool>> isLowRamDevice() =>
      guardLocal(_capabilities.isLowRamDevice);
}
