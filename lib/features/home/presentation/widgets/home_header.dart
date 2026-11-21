import 'package:material_ui/material_ui.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';
import '../cubit/home_state.dart';

/// Brand, greeting and the two header tools (notifications, account).
class const HomeHeader({
  required final String name,
  required final GreetingPeriod period,
  required final VoidCallback onNotifications,
  required final VoidCallback onAccount,
  super.key,
}) extends StatelessWidget {
  String _greeting(AppLocalizations l10n) => switch (period) {
    GreetingPeriod.morning => l10n.homeGreetingMorning(name),
    GreetingPeriod.afternoon => l10n.homeGreetingAfternoon(name),
    GreetingPeriod.evening => l10n.homeGreetingEvening(name),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final c = context.tokens;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                BrandConfig.name,
                style: text.displayMedium?.copyWith(
                  fontSize: 30,
                  height: 36 / 30,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 2),
              Semantics(
                header: true,
                child: Text(_greeting(l10n), style: text.headlineSmall),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.homeEncouragement,
                style: text.bodyMedium?.copyWith(color: c.inkMuted),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpace.s3),
        Semantics(
          button: true,
          label: l10n.homeNotificationsLabel,
          excludeSemantics: true,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onNotifications,
            child: SizedBox.square(
              dimension: AppSize.touchMin,
              child: Center(
                child: SizedBox.square(
                  dimension: 44,
                  child: Stack(
                    children: [
                      // The bell follows the theme; the unread dot is drawn
                      // here because the exported file bakes in its colours.
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 28,
                        color: c.ink,
                      ),
                      Positioned(
                        left: 24,
                        top: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: c.flame,
                            shape: BoxShape.circle,
                            border: Border.all(color: c.canvas, width: 1.5),
                          ),
                          child: const SizedBox.square(dimension: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Semantics(
          button: true,
          label: l10n.accountOpenLabel,
          excludeSemantics: true,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onAccount,
            child: SizedBox.square(
              dimension: AppSize.touchMin,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: c.palmTint,
                    shape: BoxShape.circle,
                    border: Border.all(color: c.palm, width: 1.5),
                  ),
                  child: SizedBox.square(
                    dimension: 44,
                    child: Center(
                      child: Text(
                        name.isEmpty ? '' : name.characters.first.toUpperCase(),
                        style: text.titleMedium?.copyWith(
                          fontFamily: AppFonts.display,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: c.palmStrong,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
