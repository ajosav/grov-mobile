import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// The app's line icons (24px grid, 2px round stroke), drawn from the SVGs
/// exported from the design file. Colour comes from the caller, never from
/// the file, so icons follow the theme.
class const AppIcon(
  final String asset, {
  final double size = 24,
  final Color? color,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    asset,
    width: size,
    height: size,
    semanticsLabel: semanticLabel,
    excludeFromSemantics: semanticLabel == null,
    colorFilter: color == null
        ? null
        : ColorFilter.mode(color!, BlendMode.srcIn),
  );
}
