import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_icon.dart';

/// The white ring and disc that hold a screen's icon (Figma "Icon ring").
/// [danger] tints the disc for a dead end such as an expired link.
class const AuthIconDisc(
  final String asset, {
  final double iconSize = 28,
  final bool danger = false,
  final bool colorIcon = true,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: c.surfaceRaised,
          shape: BoxShape.circle,
        ),
        child: SizedBox.square(
          dimension: 112,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: danger ? c.dangerTint : c.surfaceRaised,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: c.ink.withValues(alpha: 0.06),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: SizedBox.square(
                dimension: 72,
                child: Center(
                  child: AppIcon(
                    asset,
                    size: iconSize,
                    color: colorIcon ? c.ink : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
