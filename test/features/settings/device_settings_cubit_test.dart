import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/settings/domain/entities/device_settings.dart';
import 'package:app_mobile/features/settings/domain/repositories/device_settings_repository.dart';
import 'package:app_mobile/features/settings/presentation/cubit/device_settings_cubit.dart';
import 'package:app_mobile/features/settings/presentation/cubit/device_settings_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/cubit_factories.dart';

class _MockRepo() extends Mock implements DeviceSettingsRepository {}

void main() {
  late _MockRepo repo;
  late StreamController<Result<DeviceSettings>> controller;

  setUp(() {
    repo = _MockRepo();
    controller = StreamController<Result<DeviceSettings>>.broadcast();
    when(() => repo.watch()).thenAnswer((_) => controller.stream);
    when(() => repo.isLowRamDevice())
        .thenAnswer((_) async => const Result.ok(true));
  });
  tearDown(() => controller.close());

  blocTest<DeviceSettingsCubit, DeviceSettingsState>(
    'start loads settings and detects a low-RAM phone',
    build: () => deviceSettingsCubitFor(repo),
    act: (c) async {
      await c.start();
      controller.add(
        const Result.ok(DeviceSettings(appearance: AppearanceMode.dark)),
      );
    },
    wait: const Duration(milliseconds: 20),
    verify: (c) {
      expect(c.state.loaded, isTrue);
      expect(c.state.settings.appearance, AppearanceMode.dark);
      expect(c.state.effectiveLowEnd, isTrue); // auto + low RAM
    },
  );

  blocTest<DeviceSettingsCubit, DeviceSettingsState>(
    'a failed read keeps defaults and the app still works',
    build: () => deviceSettingsCubitFor(repo),
    act: (c) async {
      await c.start();
      controller.add(const Result.err(CacheFailure('db')));
    },
    wait: const Duration(milliseconds: 20),
    verify: (c) {
      expect(c.state.loaded, isTrue);
      expect(c.state.settings, const DeviceSettings());
    },
  );

  test('explicit preference beats the hardware flag', () {
    const base = DeviceSettingsState(lowRamDevice: true);
    expect(base.effectiveLowEnd, isTrue);
    expect(
      base
          .copyWith(
            settings: const DeviceSettings(lowEnd: LowEndPreference.off),
          )
          .effectiveLowEnd,
      isFalse,
    );
    expect(
      const DeviceSettingsState()
          .copyWith(settings: const DeviceSettings(lowEnd: LowEndPreference.on))
          .effectiveLowEnd,
      isTrue,
    );
  });

  test('setAppearance goes through the use case to the repository', () async {
    when(() => repo.setAppearance(AppearanceMode.light))
        .thenAnswer((_) async => const Result.ok(null));
    await deviceSettingsCubitFor(repo).setAppearance(AppearanceMode.light);
    verify(() => repo.setAppearance(AppearanceMode.light)).called(1);
  });
}
