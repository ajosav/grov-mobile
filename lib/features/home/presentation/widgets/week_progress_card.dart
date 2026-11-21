import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../l10n/app_localizations.dart';

/// Night card: budget used and meals completed this week.
class const WeekProgressCard({
  required final int budgetUsedPercent,
  required final int mealsCompleted,
  required final int mealsPlanned,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final c = context.tokens;
    final shape = BorderRadius.circular(AppRadius.lg);
    final label = text.bodySmall?.copyWith(color: c.onNight);
    final value = text.displayMedium;
    final fraction = (budgetUsedPercent / 100).clamp(0.0, 1.0);

    return Semantics(
      container: true,
      label:
          '${l10n.homeWeekProgressTitle}. ${l10n.homeBudgetUsed} '
          '${l10n.homeBudgetPercent(budgetUsedPercent)}. '
          '${l10n.homeMealsCompleted} '
          '${l10n.homeMealsCount(mealsCompleted, mealsPlanned)}',
      excludeSemantics: true,
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: shape,
          child: DecoratedBox(
            decoration: BoxDecoration(color: c.night),
            child: Stack(
              children: [
                // Decorative artwork, behind the content.
                Positioned.fill(child: _Pattern(night: c)),
                Padding(
                  padding: const EdgeInsets.all(AppSpace.s5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeWeekProgressTitle,
                        style: text.titleMedium?.copyWith(color: c.onNight),
                      ),
                      const SizedBox(height: AppSpace.s4),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: AppSpace.s5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(l10n.homeBudgetUsed, style: label),
                                    const SizedBox(height: AppSpace.s1),
                                    Text(
                                      l10n.homeBudgetPercent(budgetUsedPercent),
                                      style: value?.copyWith(color: c.flame),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: c.inkMuted),
                                ),
                              ),
                              child: const SizedBox(width: 1),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: AppSpace.s5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(l10n.homeMealsCompleted, style: label),
                                    const SizedBox(height: AppSpace.s1),
                                    Text(
                                      l10n.homeMealsCount(
                                        mealsCompleted,
                                        mealsPlanned,
                                      ),
                                      style: value?.copyWith(color: c.onNight),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpace.s4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: SizedBox(
                          height: 8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: c.inkMuted),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: fraction,
                                heightFactor: 1,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: c.flame,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.pill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

/// Warm glow (bottom right), rings (top right) and contours (bottom). The
/// glow is a radial gradient: the exported SVG relies on a blur filter that
/// the SVG renderer does not draw.
class const _Pattern({required final AppColors night}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          right: -60 - 70,
          bottom: -50 - 70,
          width: 200 + 140,
          height: 140 + 140,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  night.flame.withValues(alpha: 0.3),
                  night.flame.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          width: 240,
          height: 220,
          child: SvgPicture.asset(AppAssets.heroRings, fit: BoxFit.fill),
        ),
        Positioned(
          left: -10,
          right: -10,
          bottom: -10,
          height: 110,
          child: Opacity(
            opacity: 0.1,
            child: SvgPicture.asset(
              AppAssets.heroContour,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    ),
  );
}
