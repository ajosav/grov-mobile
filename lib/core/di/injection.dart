import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/device_identity_data_source.dart';
import '../../features/auth/data/datasources/gated_auth_api.dart';
import '../../features/auth/data/datasources/sign_on_api.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/complete_phone.dart';
import '../../features/auth/domain/usecases/complete_profile.dart';
import '../../features/auth/domain/usecases/get_terms_version.dart';
import '../../features/auth/domain/usecases/request_sign_in_code.dart';
import '../../features/auth/domain/usecases/verify_sign_in_code.dart';
import '../../features/auth/presentation/cubit/email_code_cubit.dart';
import '../../features/auth/presentation/cubit/phone_cubit.dart';
import '../../features/auth/presentation/cubit/sign_on_cubit.dart';
import '../../features/session/data/datasources/auth_api.dart';
import '../../features/session/data/datasources/session_api.dart';
import '../../features/session/data/datasources/session_local_data_source.dart';
import '../../features/session/data/datasources/session_remote_data_source.dart';
import '../../features/session/data/repositories/session_repository_impl.dart';
import '../../features/session/domain/repositories/session_repository.dart';
import '../../features/home/data/repositories/fixture_home_repository.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/watch_home.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/session/domain/usecases/refresh_session.dart';
import '../../features/session/domain/usecases/restore_session.dart';
import '../../features/session/domain/usecases/save_session.dart';
import '../../features/session/domain/usecases/sign_out.dart';
import '../../features/session/presentation/cubit/session_cubit.dart';
import '../../features/settings/data/repositories/device_settings_repository_impl.dart';
import '../../features/settings/domain/repositories/device_settings_repository.dart';
import '../../features/settings/domain/usecases/detect_low_ram_device.dart';
import '../../features/settings/domain/usecases/set_appearance.dart';
import '../../features/settings/domain/usecases/set_low_end.dart';
import '../../features/settings/domain/usecases/watch_device_settings.dart';
import '../../features/settings/presentation/cubit/device_settings_cubit.dart';
import '../../features/sync/data/repositories/sync_repository_impl.dart';
import '../../features/sync/domain/repositories/sync_repository.dart';
import '../../features/sync/domain/usecases/get_is_online.dart';
import '../../features/sync/domain/usecases/watch_last_synced_at.dart';
import '../../features/sync/domain/usecases/watch_online.dart';
import '../../features/sync/presentation/cubit/sync_status_cubit.dart';
import '../connectivity/connectivity_service.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';
import '../network/interceptors.dart';
import '../platform/clock.dart';
import '../platform/device_capabilities.dart';
import '../router/app_router.dart';

final getIt = GetIt.instance;

/// Manual registration, no code generation: it is readable, and the startup
/// path stays free of reflection. Everything is lazy, so only what the first
/// screen touches is built before the first frame.
///
/// Rules:
/// - Repositories are registered against their domain interface.
/// - Presentation gets use cases, never repositories.
/// - Cubits/Blocs that live for the whole app (session, settings, sync) are
///   lazy singletons. Screen-scoped Cubits/Blocs are factories, created by a
///   `BlocProvider` in the route that owns them.
Future<void> configureDependencies({AppDatabase? database}) async {
  _core(database);
  _session();
  _auth();
  _settings();
  _sync();
  _home();
  getIt.registerLazySingleton<GoRouter>(
    () => buildRouter(getIt<SessionCubit>()),
  );
}

void _core(AppDatabase? database) {
  getIt
    ..registerLazySingleton<AppDatabase>(
      () => database ?? AppDatabase(),
      dispose: (db) => db.close(),
    )
    ..registerLazySingleton<Clock>(SystemClock.new)
    ..registerLazySingleton<ConnectivityService>(ConnectivityPlusService.new)
    ..registerLazySingleton<DeviceCapabilities>(PlatformDeviceCapabilities.new)
    ..registerLazySingleton<TokenProvider>(() => getIt<SessionCubit>())
    ..registerLazySingleton<Dio>(() => buildDio(getIt<TokenProvider>()));
}

void _session() {
  getIt
    // Retrofit API on the interceptor-free client: refresh must never recurse.
    ..registerLazySingleton(() => AuthApi(buildBareDio()))
    ..registerLazySingleton(SessionLocalDataSource.new)
    ..registerLazySingleton(
      () => SessionRemoteDataSource(getIt(), () => SessionApi(getIt<Dio>())),
    )
    ..registerLazySingleton<SessionRepository>(
      () => SessionRepositoryImpl(local: getIt(), remote: getIt()),
    )
    ..registerLazySingleton(() => RestoreSession(getIt()))
    ..registerLazySingleton(() => SaveSession(getIt()))
    ..registerLazySingleton(() => SignOut(getIt()))
    ..registerLazySingleton(() => RefreshSession(getIt()))
    ..registerLazySingleton(
      () => SessionCubit(
        restoreSession: getIt(),
        saveSession: getIt(),
        signOut: getIt(),
        refreshSession: getIt(),
      ),
      dispose: (c) => c.close(),
    );
}

void _auth() {
  getIt
    // Public calls on the interceptor-free Dio; the gate call (phone) needs the gated session's bearer token, so it uses the app Dio.
    ..registerLazySingleton(() => SignOnApi(buildBareDio()))
    ..registerLazySingleton(() => GatedAuthApi(getIt<Dio>()))
    ..registerLazySingleton(DeviceIdentityDataSource.new)
    ..registerLazySingleton(
      () => AuthRemoteDataSource(getIt(), getIt(), getIt()),
    )
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    ..registerLazySingleton(() => GetTermsVersion(getIt()))
    ..registerLazySingleton(() => RequestSignInCode(getIt()))
    ..registerLazySingleton(() => VerifySignInCode(getIt()))
    ..registerLazySingleton(() => CompleteProfile(getIt()))
    ..registerLazySingleton(() => CompletePhone(getIt()))
    // Screen- and flow-scoped: created by the route that owns them.
    ..registerFactory(
      () => SignOnCubit(
        requestCode: getIt(),
        completeProfile: getIt(),
        getTermsVersion: getIt(),
      ),
    )
    ..registerFactoryParam<EmailCodeCubit, String, DateTime?>(
      (email, nextSendAt) => EmailCodeCubit(
        verifyCode: getIt(),
        requestCode: getIt(),
        email: email,
        nextSendAt: nextSendAt,
      ),
    )
    ..registerFactory(() => PhoneCubit(getIt()));
}

void _settings() {
  getIt
    ..registerLazySingleton<DeviceSettingsRepository>(
      () => DeviceSettingsRepositoryImpl(
        getIt<AppDatabase>().settingsDao,
        getIt(),
      ),
    )
    ..registerLazySingleton(() => WatchDeviceSettings(getIt()))
    ..registerLazySingleton(() => SetAppearance(getIt()))
    ..registerLazySingleton(() => SetLowEnd(getIt()))
    ..registerLazySingleton(() => DetectLowRamDevice(getIt()))
    ..registerLazySingleton(
      () => DeviceSettingsCubit(
        watchDeviceSettings: getIt(),
        setAppearance: getIt(),
        setLowEnd: getIt(),
        detectLowRamDevice: getIt(),
      ),
      dispose: (c) => c.close(),
    );
}

void _sync() {
  getIt
    ..registerLazySingleton<SyncRepository>(
      () => SyncRepositoryImpl(getIt(), getIt<AppDatabase>().cacheDao),
    )
    ..registerLazySingleton(() => GetIsOnline(getIt()))
    ..registerLazySingleton(() => WatchOnline(getIt()))
    ..registerLazySingleton(() => WatchLastSyncedAt(getIt()))
    ..registerLazySingleton(
      () => SyncStatusCubit(
        getIsOnline: getIt(),
        watchOnline: getIt(),
        watchLastSyncedAt: getIt(),
      ),
      dispose: (c) => c.close(),
    );
}

void _home() {
  getIt
    // Fixture until the API has a home summary (DECISIONS M-043).
    ..registerLazySingleton<HomeRepository>(FixtureHomeRepository.new)
    ..registerLazySingleton(() => WatchHome(getIt()))
    ..registerFactory(() => HomeCubit(watchHome: getIt(), clock: getIt()));
}
