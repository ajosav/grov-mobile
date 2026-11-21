import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../l10n/app_localizations.dart';

/// The eye at the end of a password field.
class const PasswordVisibilityButton({
  required final bool obscured,
  required final VoidCallback onToggle,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IconButton(
      onPressed: onToggle,
      tooltip: obscured ? l10n.authShowPassword : l10n.authHidePassword,
      icon: AppIcon(
        AppAssets.eye,
        color: obscured ? context.tokens.inkMuted : context.tokens.ink,
      ),
    );
  }
}
