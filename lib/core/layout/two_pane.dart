import 'package:flutter/widgets.dart';

import 'app_window.dart';

class const TwoPane({
  required final Widget primary,
  required final Widget secondary,
  final double primaryWidth = 360,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final window = AppWindow.of(context);
    if (!window.canShowTwoPanes) return primary;

    final hinge = window.hinge;
    if (hinge != null && window.isSpannedHorizontally) {
      return Row(
        children: [
          SizedBox(width: hinge.left, child: primary),
          SizedBox(width: hinge.width),
          Expanded(child: secondary),
        ],
      );
    }
    return Row(
      children: [
        SizedBox(width: primaryWidth, child: primary),
        Expanded(child: secondary),
      ],
    );
  }
}
