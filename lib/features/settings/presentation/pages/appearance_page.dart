import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/layout/content_frame.dart';
import '../../../../core/layout/app_screen.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/device_settings.dart';
import '../cubit/device_settings_cubit.dart';
import '../cubit/device_settings_state.dart';

class const AppearanceView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final cubit = context.read<DeviceSettingsCubit>();

    return AppScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(l10n.appearanceTitle)),
        body: ContentFrame(
          maxWidth: ContentFrame.formWidth,
          child: BlocBuilder<DeviceSettingsCubit, DeviceSettingsState>(
            buildWhen: (a, b) => a.settings != b.settings,
            builder: (context, state) => ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.s4),
              children: [
                SegmentedButton<AppearanceMode>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: AppearanceMode.system,
                      label: Text(l10n.appearanceSystem),
                    ),
                    ButtonSegment(
                      value: AppearanceMode.light,
                      label: Text(l10n.appearanceLight),
                    ),
                    ButtonSegment(
                      value: AppearanceMode.dark,
                      label: Text(l10n.appearanceDark),
                    ),
                  ],
                  selected: {state.settings.appearance},
                  onSelectionChanged: (s) => cubit.setAppearance(s.first),
                  style: const ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                      Size(0, AppSize.touchMin),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.s8),
                Text(l10n.lowEndTitle, style: text.titleMedium),
                const SizedBox(height: AppSpace.s1),
                Text(
                  l10n.lowEndHelp(BrandConfig.name),
                  style: text.bodyMedium?.copyWith(
                    color: context.tokens.inkMuted,
                  ),
                ),
                const SizedBox(height: AppSpace.s3),
                SegmentedButton<LowEndPreference>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: LowEndPreference.auto,
                      label: Text(l10n.lowEndAuto),
                    ),
                    ButtonSegment(
                      value: LowEndPreference.on,
                      label: Text(l10n.lowEndOn),
                    ),
                    ButtonSegment(
                      value: LowEndPreference.off,
                      label: Text(l10n.lowEndOff),
                    ),
                  ],
                  selected: {state.settings.lowEnd},
                  onSelectionChanged: (s) => cubit.setLowEnd(s.first),
                  style: const ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                      Size(0, AppSize.touchMin),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
