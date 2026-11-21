import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/glass_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/home_meal_idea.dart';
import '../../domain/entities/meal_time.dart';
import 'status_tag.dart';

class const MealIdeaCard({
  required final HomeMealIdea meal,
  required final VoidCallback onTap,
  super.key,
}) extends StatelessWidget {
  String _mealTime(AppLocalizations l10n) => switch (meal.mealTime) {
    MealTime.breakfast => l10n.mealTimeBreakfast,
    MealTime.lunch => l10n.mealTimeLunch,
    MealTime.dinner => l10n.mealTimeDinner,
    MealTime.snack => l10n.mealTimeSnack,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final c = context.tokens;
    final url = meal.photoUrl;
    final asset = meal.photoAsset;
    final placeholder = DecoratedBox(
      decoration: BoxDecoration(color: c.palmTint),
    );
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(AppSpace.s3 - 2),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: SizedBox(
                  width: 96,
                  height: 84,
                  child: url != null
                      // Decode at the size drawn (3x), not the full file.
                      ? Image.network(
                          url,
                          fit: BoxFit.cover,
                          cacheWidth: 288,
                          excludeFromSemantics: true,
                          errorBuilder: (_, _, _) => placeholder,
                        )
                      : asset != null
                      // TEMP test data, see HomeMealIdea.photoAsset.
                      ? Image.asset(
                          asset,
                          fit: BoxFit.cover,
                          cacheWidth: 288,
                          excludeFromSemantics: true,
                        )
                      : placeholder,
                ),
              ),
              const SizedBox(width: AppSpace.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meal.title, style: text.titleMedium),
                    const SizedBox(height: AppSpace.s1),
                    Text(
                      l10n.homeMealSubtitle(_mealTime(l10n)),
                      style: text.bodySmall?.copyWith(color: c.inkMuted),
                    ),
                    if (meal.cooked) ...[
                      const SizedBox(height: AppSpace.s1),
                      StatusTag(l10n.homeCooked),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpace.s3),
              Icon(Icons.chevron_right, size: 20, color: c.ink),
            ],
          ),
        ),
      ),
    );
  }
}
