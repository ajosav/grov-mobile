import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
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
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/otp_boxes.dart';
import '../widgets/resend_countdown.dart';

/// The 6-digit sign-in code. A right code signs an existing account in, or
/// opens the profile screen for a new address.
class const EmailCodeView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<EmailCodeCubit>();
    final session = context.read<SessionCubit>();
    return BlocConsumer<EmailCodeCubit, EmailCodeState>(
      listenWhen: (a, b) =>
          (a.verifiedSession == null && b.verifiedSession != null) ||
          (a.profileTicket == null && b.profileTicket != null),
      listener: (context, state) async {
        // Let the green boxes and "Taking you in…" register before moving on.
        await Future<void>.delayed(const Duration(milliseconds: 900));
        if (!context.mounted) {
          return;
        }
        final verified = state.verifiedSession;
        final ticket = state.profileTicket;
        if (verified != null) {
          await session.signedIn(verified);
        } else if (ticket != null) {
          context.push(Routes.profile, extra: ticket);
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
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              context.go(Routes.welcome);
            }
          },
          child: AuthScaffold(
            onBack: () => context.go(Routes.welcome),
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
                  ? null
                  : locked
                  ? cubit.resend
                  : state.code.length == EmailCodeCubit.length
                  ? cubit.verify
                  : null,
            ),
          ),
        );
      },
    );
  }
}
