import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;

/// Bold underlined text action ("Change", "Forgot password?"). 48dp target.
class const AuthLink(
  final String label, {
  required final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge
        ?.copyWith(decoration: TextDecoration.underline);
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: context.tokens.ink,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.s2),
      ),
      child: Text(label, style: style),
    );
  }
}
