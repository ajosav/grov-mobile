import 'package:material_ui/material_ui.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/glass_card.dart';
import '../../../../l10n/app_localizations.dart';

class const StockListRow({
  required final int itemsToBuy,
  required final int kobo,
  required final VoidCallback onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final c = context.tokens;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: c.palmTint,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: SizedBox.square(
                  dimension: 44,
                  child: Center(
                    child: Icon(Icons.checklist, size: 22, color: c.palmStrong),
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.homeStockListTitle, style: text.labelLarge),
                    const SizedBox(height: 2),
                    Text(
                      l10n.homeStockListSummary(itemsToBuy, formatNaira(kobo)),
                      style: text.bodySmall?.copyWith(color: c.inkMuted),
                    ),
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
