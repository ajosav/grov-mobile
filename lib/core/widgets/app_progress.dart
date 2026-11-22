import 'package:material_ui/material_ui.dart';

import '../theme/app_tokens.dart' hide formatNaira;

class const AppProgress({
  final double size = 24,
  final String? semanticLabel,
  final Color? color,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    liveRegion: semanticLabel != null,
    child: SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: size <= 20 ? 2 : 2.5,
        color: color ?? context.tokens.ink,
      ),
    ),
  );
}
