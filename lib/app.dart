import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/config/brand_config.dart';
import 'core/di/injection.dart';
import 'core/theme/app_performance.dart';
import 'core/theme/app_theme.dart';
import 'features/session/presentation/cubit/session_cubit.dart';
import 'features/settings/domain/entities/device_settings.dart';
import 'features/settings/presentation/cubit/device_settings_cubit.dart';
import 'features/settings/presentation/cubit/device_settings_state.dart';
import 'features/sync/presentation/cubit/sync_status_cubit.dart';
import 'l10n/app_localizations.dart';

class const AppRoot({super.key}) extends StatefulWidget {
  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState() extends State<AppRoot> {
  final _light = AppTheme.light();
  final _dark = AppTheme.dark();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<SessionCubit>()),
        BlocProvider.value(value: getIt<DeviceSettingsCubit>()),
        BlocProvider.value(value: getIt<SyncStatusCubit>()),
      ],
      child: BlocConsumer<DeviceSettingsCubit, DeviceSettingsState>(
        listenWhen: (a, b) => a.effectiveLowEnd != b.effectiveLowEnd,
        listener: (context, state) {
          PaintingBinding.instance.imageCache.maximumSizeBytes = AppPerformance(
            lowEnd: state.effectiveLowEnd,
          ).imageCacheBytes;
        },
        buildWhen: (a, b) =>
            a.settings.appearance != b.settings.appearance ||
            a.effectiveLowEnd != b.effectiveLowEnd,
        builder: (context, state) {
          final performance = AppPerformance(lowEnd: state.effectiveLowEnd);
          return MaterialApp.router(
            onGenerateTitle: (_) => BrandConfig.name,
            debugShowCheckedModeBanner: false,
            routerConfig: getIt<GoRouter>(),
            theme: _light,
            darkTheme: _dark,
            themeMode: switch (state.settings.appearance) {
              AppearanceMode.system => ThemeMode.system,
              AppearanceMode.light => ThemeMode.light,
              AppearanceMode.dark => ThemeMode.dark,
            },
            themeAnimationDuration: performance.themeAnimation(context),
            locale: const Locale('en'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            builder: (context, child) =>
                AppPerformanceScope(performance: performance, child: child!),
          );
        },
      ),
    );
  }
}
