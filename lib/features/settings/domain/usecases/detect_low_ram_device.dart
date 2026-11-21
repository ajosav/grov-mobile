import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/device_settings_repository.dart';

class const DetectLowRamDevice(final DeviceSettingsRepository _repository)
    implements UseCase<bool, NoParams> {
  @override
  Future<Result<bool>> call(NoParams params) => _repository.isLowRamDevice();
}
