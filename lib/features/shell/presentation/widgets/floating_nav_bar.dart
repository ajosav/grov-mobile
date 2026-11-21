import 'dart:ui';

import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_performance.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';
import 'app_tab.dart';

/// Compact-window navigation: a floating glass pill with the Plan tab raised
/// in the middle. Wider windows use the rail instead.
class const FloatingNavBar({
  required final int selectedIndex,
  required final ValueChanged<int> onSelected,
  super.key,
}) extends StatelessWidget {
  /// How far the raised Plan button rises above the pill.
  static const _rise = 26.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.tokens;
    final canBlur = AppPerformance.of(context).allowsBlur(context);
    final shape = BorderRadius.circular(AppRadius.pill);

    final pill = DecoratedBox(
      decoration: BoxDecoration(
        color: canBlur ? c.glass : c.glassStrong,
        borderRadius: shape,
        border: Border.all(color: c.glassEdge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            for (final tab in AppTab.values)
              Expanded(
                child: _NavItem(
                  tab: tab,
                  label: tab.label(l10n),
                  selected: tab.index == selectedIndex,
                  onTap: () => onSelected(tab.index),
                ),
              ),
          ],
        ),
      ),
    );

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: AppSpace.s2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.s4,
          _rise,
          AppSpace.s4,
          AppSpace.s2,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: shape,
                boxShadow: [
                  BoxShadow(
                    color: c.glassEdge,
                    offset: const Offset(0, 12),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: canBlur
                  ? ClipRRect(
                      borderRadius: shape,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: pill,
                      ),
                    )
                  : pill,
            ),
            Positioned(
              top: -_rise,
              child: _PlanButton(
                label: AppTab.plan.label(l10n),
                onTap: () => onSelected(AppTab.plan.index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _NavItem({
  required final AppTab tab,
  required final String label,
  required final bool selected,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final isPlan = tab == AppTab.plan;
    final color = selected ? c.flameStrong : c.inkMuted;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // The raised button draws the Plan icon; keep the slot.
              if (isPlan)
                const SizedBox(height: 20)
              else
                Icon(
                  selected ? tab.selectedIcon : tab.icon,
                  size: 20,
                  color: selected ? c.flame : c.inkMuted,
                ),
              const SizedBox(height: AppSpace.s1),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _PlanButton({
  required final String label,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: c.action,
            shape: BoxShape.circle,
            border: Border.all(color: c.canvas, width: 3),
            boxShadow: [
              BoxShadow(
                color: c.glassEdge,
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: SizedBox.square(
            dimension: AppSize.planButton,
            child: Center(
              child: Icon(
                Icons.calendar_month_outlined,
                size: 22,
                color: c.onAction,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
