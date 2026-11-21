import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/brand_logo.dart';
import '../../../../core/widgets/glass_card.dart';

/// The logo card beside the form on wide windows and folds.
class const BrandPanel({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpace.s4),
    child: SizedBox.expand(
      child: GlassCard(
        radius: AppRadius.xl,
        padding: EdgeInsets.zero,
        child: const Center(child: BrandLogo()),
      ),
    ),
  );
}
