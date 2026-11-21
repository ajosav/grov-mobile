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

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  await configureDependencies();
  runApp(const AppRoot());
  WidgetsBinding.instance.addObserver(MemoryTrimObserver());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    getIt<SessionCubit>().restore();
    getIt<DeviceSettingsCubit>().start();
    getIt<SyncStatusCubit>().start();
  });
}
