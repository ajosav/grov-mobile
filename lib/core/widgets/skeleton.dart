import 'package:material_ui/material_ui.dart';

import '../../l10n/app_localizations.dart';
import '../theme/app_tokens.dart' hide formatNaira;

class const Skeleton({
  required final Widget child,
  final String? label,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Semantics(
    label: label ?? AppLocalizations.of(context).loadingLabel,
    liveRegion: true,
    child: ExcludeSemantics(child: child),
  );
}

class const SkeletonBox({
  final double? width,
  final double height = 16,
  final double radius = AppRadius.sm,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: context.tokens.surfaceSunken,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

/// A ghost avatar or icon tile.
class const SkeletonCircle({final double size = 44, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: context.tokens.surfaceSunken,
        shape: BoxShape.circle,
      ),
    ),
  );
}
