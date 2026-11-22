import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_icon.dart';
import 'auth_link.dart';

enum AuthBannerKind() {
  /// A real failure: danger tint, alert icon.
  danger,

  /// Neutral news such as being offline: sky tint, info icon.
  info,
}

/// Inline notice with an optional action on the right (Figma banner).
class const AuthBanner(
  final String text, {
  final AuthBannerKind kind = AuthBannerKind.danger,
  final String? actionLabel,
  final VoidCallback? onAction,
  final Widget? trailing,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final isDanger = kind == AuthBannerKind.danger;
    return Semantics(
      container: true,
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDanger ? c.dangerTint : c.skyTint,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.s4,
            vertical: AppSpace.s3,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcon(
                isDanger ? AppAssets.alert : AppAssets.info,
                size: 20,
                color: isDanger ? c.danger : c.skyStrong,
              ),
              const SizedBox(width: AppSpace.s3),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (actionLabel != null) ...[
                const SizedBox(width: AppSpace.s2),
                AuthLink(actionLabel!, onTap: onAction),
              ] else if (trailing != null) ...[
                const SizedBox(width: AppSpace.s2),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
