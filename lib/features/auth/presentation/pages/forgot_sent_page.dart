import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/resend_countdown.dart';

/// "Check your email": the reset link is on its way.
class const ForgotSentView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<ForgotPasswordCubit>();
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      // A resend sets `sent` again; this page is the one on top, so it is the
      // one that acknowledges it.
      listenWhen: (a, b) => b.sent && !a.sent,
      listener: (context, _) => cubit.sentHandled(),
      buildWhen: (a, b) =>
          a.email != b.email ||
          a.nextSendAt != b.nextSendAt ||
          a.busy != b.busy,
      builder: (context, state) => AuthScaffold(
        onBack: context.pop,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.s4,
          children: [
            const Center(child: AuthIconDisc(AppAssets.mail, iconSize: 30)),
            AuthHeading(
              l10n.codeTitle,
              subtitle: l10n.forgotSentBody(state.email),
            ),
            Center(
              child: ResendCountdown(
                nextSendAt: state.nextSendAt,
                waitLabel: l10n.forgotResendIn,
                resendLabel: l10n.helpSendAgain,
                busy: state.busy,
                onResend: cubit.send,
              ),
            ),
          ],
        ),
        actions: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.s3,
          children: [
            // Opening the mail app needs a link launcher, which is not added
            // yet: say what to do instead.
            AppButton(
              label: l10n.forgotOpenMail,
              onPressed: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10n.forgotOpenMailHint))),
            ),
            AppButton(
              label: l10n.forgotDidntGet,
              kind: AppButtonKind.secondary,
              onPressed: () => context.push(Routes.forgotHelp),
            ),
          ],
        ),
      ),
    );
  }
}
