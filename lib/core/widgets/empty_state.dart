import 'package:material_ui/material_ui.dart';

import '../theme/app_tokens.dart' hide formatNaira;

class const EmptyState({
  required final String title,
  required final String body,
  final IconData? icon,
  final Widget? action,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final text = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 40, color: c.inkMuted),
              const SizedBox(height: AppSpace.s4),
            ],
            Text(title, style: text.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.s2),
            Text(
              body,
              style: text.bodyMedium?.copyWith(color: c.inkMuted),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpace.s5),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
