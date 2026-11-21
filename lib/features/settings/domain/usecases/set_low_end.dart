import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/device_settings.dart';
import '../repositories/device_settings_repository.dart';

class const SetLowEnd(final DeviceSettingsRepository _repository)
    implements UseCase<void, LowEndPreference> {
  @override
  Future<Result<void>> call(LowEndPreference params) =>
      _repository.setLowEnd(params);
}
