import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';

/// "Didn't get the email?": three things to check, then send again.
class const ForgotHelpView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<ForgotPasswordCubit>();
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (a, b) => a.email != b.email || a.busy != b.busy,
      builder: (context, state) => AuthScaffold(
        onBack: context.pop,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.s4,
          children: [
            const Center(child: AuthIconDisc(AppAssets.info)),
            AuthHeading(l10n.helpTitle, subtitle: l10n.helpSubtitle),
            GlassCard(
              padding: const EdgeInsets.all(AppSpace.s4),
              radius: AppRadius.md,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpace.s3,
                children: [
                  _Tip(l10n.helpTipSpam),
                  _Tip(l10n.helpTipAddress(state.email)),
                  _Tip(l10n.helpTipNetwork),
                ],
              ),
            ),
          ],
        ),
        actions: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.s3,
          children: [
            AppButton(
              label: l10n.helpSendAgain,
              loading: state.busy,
              onPressed: () async {
                await cubit.send();
                if (context.mounted && cubit.state.error == null) {
                  context.pop();
                }
              },
            ),
            AppButton(
              label: l10n.helpDifferentEmail,
              kind: AppButtonKind.secondary,
              onPressed: () => context.go(Routes.forgot),
            ),
            // No support contact is decided yet; say so instead of a dead link.
            Center(
              child: AuthLink(
                l10n.helpContactSupport,
                onTap: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(l10n.helpContactSoon))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _Tip(final String text) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppIcon(AppAssets.checkCircle, size: 20, color: context.tokens.ink),
      const SizedBox(width: 10),
      Expanded(
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
    ],
  );
}
