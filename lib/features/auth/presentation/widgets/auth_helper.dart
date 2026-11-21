import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_icon.dart';

/// The 12px line under a field. An error carries the alert icon and a word,
/// never colour alone.
class const AuthHelper(final String text, {final bool error = false, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final style = Theme.of(context).textTheme.bodySmall;
    if (!error) {
      return Text(text, style: style?.copyWith(color: c.inkMuted));
    }
    return Semantics(
      liveRegion: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(AppAssets.alert, size: AppSize.iconSm, color: c.danger),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: style?.copyWith(color: c.danger)),
          ),
        ],
      ),
    );
  }
}
