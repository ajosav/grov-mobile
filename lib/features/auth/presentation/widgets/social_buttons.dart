import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../l10n/app_localizations.dart';

/// Google, and Apple on iOS (Apple's rule, not a layout fork). 88x56 logo-only
/// buttons, 1px line-strong border.
class const SocialButtons({
  required final VoidCallback onGoogle,
  required final VoidCallback onApple,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Social(AppAssets.google, l10n.authGoogleLabel, onGoogle),
        if (defaultTargetPlatform == TargetPlatform.iOS) ...[
          const SizedBox(width: AppSpace.s3),
          _Social(AppAssets.apple, l10n.authAppleLabel, onApple),
        ],
      ],
    );
  }
}

class const _Social(
  final String asset,
  final String label,
  final VoidCallback onTap,
) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: c.surfaceRaised,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: c.lineStrong),
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: SizedBox(
            width: 88,
            height: 56,
            child: Center(child: AppIcon(asset)),
          ),
        ),
      ),
    );
  }
}
