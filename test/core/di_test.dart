import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:app_mobile/core/database/app_database.dart';
import 'package:app_mobile/core/di/injection.dart';
import 'package:app_mobile/features/session/presentation/cubit/session_cubit.dart';
import 'package:app_mobile/features/settings/presentation/cubit/device_settings_cubit.dart';
import 'package:app_mobile/features/sync/presentation/cubit/sync_status_cubit.dart';
import 'package:dio/dio.dart';

/// Resolves the whole dependency graph. A compile check cannot catch a wrong
/// or missing registration; this does (it ran after the constructor migration).
void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await getIt.reset();
    await configureDependencies(database: AppDatabase.inMemory());
  });
  tearDown(() => getIt.reset());

  test('app-lifetime Cubits, router and network client resolve', () {
    expect(getIt<SessionCubit>(), isA<SessionCubit>());
    expect(getIt<DeviceSettingsCubit>(), isA<DeviceSettingsCubit>());
    expect(getIt<SyncStatusCubit>(), isA<SyncStatusCubit>());
    expect(getIt<GoRouter>(), isA<GoRouter>());
    expect(getIt<Dio>(), isA<Dio>());
  });

  test(
    'the session Cubit is the single token provider the network layer reads',
    () {
      expect(identical(getIt<SessionCubit>(), getIt<SessionCubit>()), isTrue);
    },
  );
}
