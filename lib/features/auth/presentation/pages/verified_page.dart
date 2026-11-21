import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_scaffold.dart';

/// "You're in": the account is ready. Plan set-up is not built yet, so both
/// buttons land on the app for now.
class const VerifiedView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.tokens;
    return AuthScaffold(
      centerBody: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.s6 + 4,
        children: [
          const Center(child: AuthIconDisc(AppAssets.check, iconSize: 44)),
          AuthHeading(l10n.doneTitle, subtitle: l10n.doneBody),
        ],
      ),
      actions: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpace.s3,
        children: [
          AppButton(
            label: l10n.doneSetup,
            onPressed: () => context.go(Routes.plan),
            trailing: AppIcon(
              AppAssets.arrowRight,
              size: 18,
              color: c.onAction,
            ),
          ),
          AppButton(
            label: l10n.doneNotNow,
            kind: AppButtonKind.secondary,
            onPressed: () => context.go(Routes.home),
          ),
        ],
      ),
    );
  }
}
