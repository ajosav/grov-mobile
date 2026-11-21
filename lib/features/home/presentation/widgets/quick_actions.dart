import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';

/// The four quick actions as equal tiles. Tiles share a row height so a label
/// that wraps at large text sizes does not make the row ragged.
class const QuickActions({
  required final VoidCallback onViewPlan,
  required final VoidCallback onBulkCooked,
  required final VoidCallback onSharingSlot,
  required final VoidCallback onAdjustBudget,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tiles = [
      _Tile(Icons.calendar_today_outlined, l10n.homeActionViewPlan, onViewPlan),
      _Tile(Icons.restaurant, l10n.homeActionBulkCooked, onBulkCooked),
      _Tile(Icons.group_outlined, l10n.homeActionSharingSlot, onSharingSlot),
      _Tile(Icons.tune, l10n.homeActionAdjustBudget, onAdjustBudget),
    ];
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < tiles.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(child: tiles[i]),
          ],
        ],
      ),
    );
  }
}

class const _Tile(
  final IconData icon,
  final String label,
  final VoidCallback onTap,
) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return Semantics(
      button: true,
      excludeSemantics: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: c.line),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.s1,
              vertical: 14,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: c.flameTint,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: SizedBox.square(
                    dimension: 40,
                    child: Center(
                      child: Icon(icon, size: 20, color: c.flameStrong),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.s2),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
