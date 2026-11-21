import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/device_settings.dart';
import '../repositories/device_settings_repository.dart';

class const SetAppearance(final DeviceSettingsRepository _repository)
    implements UseCase<void, AppearanceMode> {
  @override
  Future<Result<void>> call(AppearanceMode params) =>
      _repository.setAppearance(params);
}
