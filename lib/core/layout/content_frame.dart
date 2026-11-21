import 'package:flutter/widgets.dart';

import '../theme/app_tokens.dart' hide formatNaira;

class const ContentFrame({
  required final Widget child,
  final double maxWidth = AppSize.screenMax,
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: AppSpace.s4,
  ),
  super.key,
}) extends StatelessWidget {
  static const formWidth = 480.0;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(padding: padding, child: child),
    ),
  );
}
