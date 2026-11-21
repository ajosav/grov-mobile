import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;

/// Small pill that states a status ("Cooked"). Green means done, nothing else.
class const StatusTag(final String label, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.leafTint,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.s3 - 2,
          vertical: AppSpace.s1,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, size: 12, color: c.leafStrong),
            const SizedBox(width: AppSpace.s1),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: c.leafStrong),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
