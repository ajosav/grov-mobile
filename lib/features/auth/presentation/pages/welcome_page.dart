import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../sync/presentation/cubit/sync_status_cubit.dart';
import '../cubit/auth_error.dart';
import '../cubit/sign_on_cubit.dart';
import '../cubit/sign_on_state.dart';
import '../widgets/auth_banner.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_error_text.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/debug_panel.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_buttons.dart';
import '../widgets/terms_notice.dart';
import 'sign_on_effects.dart';

/// Welcome is the only door (D37): an email, then the server says whether to
/// log in or join. Google and Apple sit under it.
class const WelcomeView({super.key}) extends StatefulWidget {
  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState() extends State<WelcomeView> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(
      text: context.read<SignOnCubit>().state.email,
    );
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.tokens;
    final cubit = context.read<SignOnCubit>();
    final online = context.select((SyncStatusCubit s) => s.state.online);

    return BlocConsumer<SignOnCubit, SignOnState>(
      listenWhen: (a, b) => b.effect != null && a.effect != b.effect,
      listener: handleSignOnEffect,
      buildWhen: (a, b) => a.busy != b.busy || a.error != b.error,
      builder: (context, state) {
        // The offline state is the device's connectivity, nothing else. A call
        // that failed while connectivity says online (server down, wrong
        // address) is a neutral banner and never blocks another try.
        final offline = !online;
        final error = state.error;
        final scaffold = AuthScaffold(
          centerBody: true,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!AuthScaffold.showsPanel(context)) ...[
                const Center(child: BrandLogo()),
                const SizedBox(height: AppSpace.s12),
              ],
              AuthField(
                label: l10n.authEmailLabel,
                controller: _email,
                hint: l10n.authEmailHint,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.go,
                autofillHints: const [AutofillHints.email],
                hasError: error == AuthError.invalidEmail,
                errorText: error == AuthError.invalidEmail
                    ? error!.message(l10n)
                    : null,
                onChanged: cubit.emailChanged,
                onSubmitted: (_) => cubit.continueWithEmail(),
              ),
              if (offline) ...[
                const SizedBox(height: AppSpace.s3),
                AuthBanner(
                  l10n.authOfflineBanner,
                  kind: AuthBannerKind.info,
                  actionLabel: l10n.authTryAgain,
                  onAction: cubit.continueWithEmail,
                ),
              ] else if (error != null && error != AuthError.invalidEmail) ...[
                const SizedBox(height: AppSpace.s3),
                AuthErrorBanner(error, onRetry: cubit.continueWithEmail),
              ],
            ],
          ),
          actions: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton(
                label: l10n.authContinue,
                loading: state.busy,
                onPressed: offline ? null : cubit.continueWithEmail,
                trailing: AppIcon(
                  AppAssets.arrowRight,
                  size: 18,
                  color: offline ? c.onActionDisabled : c.onAction,
                ),
              ),
              const SizedBox(height: AppSpace.s3),
              const OrDivider(),
              const SizedBox(height: AppSpace.s3),
              SocialButtons(
                onGoogle: () => _socialSoon(context),
                onApple: () => _socialSoon(context),
              ),
              const SizedBox(height: AppSpace.s3),
              const TermsNotice(),
            ],
          ),
        );
        if (!kDebugMode) {
          return scaffold;
        }
        // Debug builds only: the chip that opens the sample-data panel.
        return Stack(
          children: [
            scaffold,
            const Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppSpace.s2),
                  child: DebugPanelButton(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _socialSoon(BuildContext context) => ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).authSocialSoon)),
      );
}
