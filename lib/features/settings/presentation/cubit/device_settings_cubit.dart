import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/device_settings.dart';
import '../../domain/usecases/detect_low_ram_device.dart';
import '../../domain/usecases/set_appearance.dart';
import '../../domain/usecases/set_low_end.dart';
import '../../domain/usecases/watch_device_settings.dart';
import 'device_settings_state.dart';

/// App-level state. `MaterialApp` listens to it for theme mode and the
/// performance profile. Talks only to use cases.
class DeviceSettingsCubit({
  required final WatchDeviceSettings _watchDeviceSettings,
  required final SetAppearance _setAppearance,
  required final SetLowEnd _setLowEnd,
  required final DetectLowRamDevice _detectLowRamDevice,
}) extends Cubit<DeviceSettingsState> {
  this : super(const DeviceSettingsState());

  StreamSubscription<dynamic>? _subscription;

  /// Call once after the first frame.
  Future<void> start() async {
    _subscription = _watchDeviceSettings(const NoParams()).listen((result) {
      final settings = result.valueOrNull;
      // A failed read keeps defaults: the app still works.
      emit(state.copyWith(settings: settings ?? state.settings, loaded: true));
    });
    final lowRam =
        (await _detectLowRamDevice(const NoParams())).valueOrNull ?? false;
    if (!isClosed) {
      emit(state.copyWith(lowRamDevice: lowRam));
    }
  }

  Future<void> setAppearance(AppearanceMode mode) => _setAppearance(mode);

  Future<void> setLowEnd(LowEndPreference preference) => _setLowEnd(preference);

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
