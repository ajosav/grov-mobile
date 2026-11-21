import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;

/// Display headline with a muted line under it, both centred.
class const AuthHeading(final String title, {final String? subtitle, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Semantics(
      header: true,
      container: true,
      child: Column(
        children: [
          Text(title, style: text.displayMedium, textAlign: TextAlign.center),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpace.s2),
            Text(
              subtitle!,
              style: text.bodyMedium?.copyWith(color: context.tokens.inkMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
