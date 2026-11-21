import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/device_settings.dart';
import '../repositories/device_settings_repository.dart';

class const WatchDeviceSettings(final DeviceSettingsRepository _repository)
    implements StreamUseCase<DeviceSettings, NoParams> {
  @override
  Stream<Result<DeviceSettings>> call(NoParams params) => _repository.watch();
}
