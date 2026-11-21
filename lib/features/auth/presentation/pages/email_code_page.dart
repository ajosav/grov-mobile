import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import '../../domain/mask_email.dart';
import '../cubit/auth_error.dart';
import '../cubit/email_code_cubit.dart';
import '../cubit/email_code_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_error_text.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/change_email_dialog.dart';
import '../widgets/otp_boxes.dart';
import '../widgets/resend_countdown.dart';

/// The 6-digit email code, shown to any session still gated on its email.
class const EmailCodeView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<EmailCodeCubit>();
    final session = context.read<SessionCubit>();
    return BlocConsumer<EmailCodeCubit, EmailCodeState>(
      listenWhen: (a, b) =>
          a.verifiedSession == null && b.verifiedSession != null,
      listener: (context, state) async {
        // Let the green boxes and "Taking you in…" register before moving on.
        await Future<void>.delayed(const Duration(milliseconds: 900));
        if (context.mounted) {
          await session.signedIn(state.verifiedSession!);
        }
      },
      builder: (context, state) {
        final accepted = state.status == EmailCodeStatus.accepted;
        final locked = state.status == EmailCodeStatus.locked;
        final error = state.error;
        final boxesState = accepted
            ? OtpBoxesState.success
            : locked
            ? OtpBoxesState.disabled
            : (error == AuthError.codeInvalid || error == AuthError.codeExpired)
            ? OtpBoxesState.error
            : OtpBoxesState.entering;
        return AuthScaffold(
          onBack: session.signOut,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s4,
            children: [
              Center(
                child: AuthIconDisc(
                  accepted ? AppAssets.checkCircle : AppAssets.clock,
                ),
              ),
              AuthHeading(
                accepted ? l10n.codeAcceptedTitle : l10n.codeTitle,
                subtitle: accepted ? l10n.codeAcceptedSub : l10n.codeSentTo,
              ),
              Column(
                spacing: 2,
                children: [
                  Text(
                    state.email,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  AuthLink(
                    l10n.codeChangeEmail,
                    onTap: accepted ? null : () => _changeEmail(context),
                  ),
                ],
              ),
              OtpBoxes(
                code: state.code,
                state: boxesState,
                semanticLabel: l10n.codeFieldLabel,
                onChanged: cubit.codeChanged,
              ),
              if (error != null && error != AuthError.resendTooSoon)
                AuthErrorBanner(error),
              if (!locked && !accepted)
                Center(
                  child: ResendCountdown(
                    nextSendAt: state.nextSendAt,
                    waitLabel: l10n.codeResendIn,
                    resendLabel: l10n.codeResend,
                    busy: state.resending,
                    onResend: cubit.resend,
                  ),
                ),
              Text(
                accepted
                    ? l10n.codeTakingYouIn
                    : l10n.codeNote(maskEmail(state.email)),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: context.tokens.inkMuted),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: AppButton(
            label: locked ? l10n.codeSendNew : l10n.authContinue,
            loading:
                state.status == EmailCodeStatus.verifying || state.resending,
            loadingLabel: state.resending
                ? l10n.authBusySending
                : l10n.authBusyVerifying,
            onPressed: accepted
                ? () => session.signedIn(state.verifiedSession!)
                : locked
                ? cubit.resend
                : state.code.length == EmailCodeCubit.length
                ? cubit.verify
                : null,
          ),
        );
      },
    );
  }

  Future<void> _changeEmail(BuildContext context) async {
    final cubit = context.read<EmailCodeCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    final email = await showDialog<String>(
      context: context,
      builder: (_) => const ChangeEmailDialog(),
    );
    if (email == null) {
      return;
    }
    final failure = await cubit.changeEmail(email);
    if (failure != null) {
      messenger.showSnackBar(
        SnackBar(content: Text(authErrorOf(failure).message(l10n))),
      );
    }
  }
}
