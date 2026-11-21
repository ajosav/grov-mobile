import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/brand_logo.dart';

class const SplashView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.tokens.canvas,
    body: const Center(child: BrandLogo()),
  );
}
