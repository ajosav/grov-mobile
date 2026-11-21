import 'package:material_ui/material_ui.dart';

import '../theme/app_tokens.dart' hide formatNaira;

class const AppScreen({required final Widget child, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(gradient: AppGradients.wash(context.tokens)),
    child: child,
  );
}
