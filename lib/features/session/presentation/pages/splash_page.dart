import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_progress.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../../l10n/app_localizations.dart';

class const SplashView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.tokens.canvas,
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpace.s8,
        children: [
          const BrandLogo(),
          // Restoring the session can take a moment on a slow phone: say so.
          AppProgress(
            size: 28,
            semanticLabel: AppLocalizations.of(context).startingUp,
          ),
        ],
      ),
    ),
  );
}
