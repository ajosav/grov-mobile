import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/bloc/app_bloc_observer.dart';
import 'core/di/injection.dart';
import 'core/platform/memory_trim.dart';
import 'features/session/presentation/cubit/session_cubit.dart';
import 'features/settings/presentation/cubit/device_settings_cubit.dart';
import 'features/sync/presentation/cubit/sync_status_cubit.dart';

/// Startup budget: Welcome interactive in under 2 seconds on a 2 GB phone.
///
/// Before `runApp`: only synchronous, cheap work (DI registration is lazy).
/// After the first frame: restore the session, open Drift, read settings,
/// start connectivity. Nothing awaits SQLite or secure storage before pixels.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  await configureDependencies();
  runApp(const AppRoot());
  // Release rebuildable image and SVG memory when backgrounded or under memory
  // pressure (Play's bitmap-memory vital; 2 GB phones).
  WidgetsBinding.instance.addObserver(MemoryTrimObserver());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    getIt<SessionCubit>().restore();
    getIt<DeviceSettingsCubit>().start();
    getIt<SyncStatusCubit>().start();
  });
}
