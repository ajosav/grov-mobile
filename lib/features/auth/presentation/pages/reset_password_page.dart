import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_progress.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import '../../domain/entities/password_problem.dart';
import '../cubit/auth_error.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_checklist.dart';
import '../widgets/password_visibility_button.dart';

/// Opened from the email link: set a new password, or learn the link is dead.
class const ResetPasswordView({super.key}) extends StatefulWidget {
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState() extends State<ResetPasswordView> {
  final _password = TextEditingController();
  var _obscured = true;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<ResetPasswordCubit>();
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (a, b) =>
          a.signedInSession == null && b.signedInSession != null,
      listener: (context, state) async {
        await context.read<SessionCubit>().signedIn(state.signedInSession!);
        if (context.mounted) {
          context.go(Routes.home);
        }
      },
      builder: (context, state) {
        void toWelcome() => context.go(Routes.welcome);
        if (state.link == ResetLinkStatus.checking) {
          return AuthScaffold(
            centerBody: true,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpace.s4,
                children: [
                  AppProgress(size: 32, semanticLabel: l10n.authLoadingLink),
                  Text(
                    l10n.authLoadingLink,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: context.tokens.inkMuted),
                  ),
                ],
              ),
            ),
          );
        }
        if (state.link == ResetLinkStatus.dead) {
          return AuthScaffold(
            onBack: toWelcome,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpace.s4,
              children: [
                const Center(
                  child: AuthIconDisc(AppAssets.clock, danger: true),
                ),
                AuthHeading(
                  l10n.linkExpiredTitle,
                  subtitle: l10n.linkExpiredBody,
                ),
              ],
            ),
            actions: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpace.s3,
              children: [
                AppButton(
                  label: l10n.linkSendNew,
                  onPressed: () => context.go(Routes.forgot),
                ),
                Center(child: AuthLink(l10n.forgotBack, onTap: toWelcome)),
              ],
            ),
          );
        }
        final error = state.error;
        final commonFailed =
            error == AuthError.passwordCommon ||
            state.problems.contains(PasswordProblem.common) ||
            state.problems.contains(PasswordProblem.emailLocalPart);
        return AuthScaffold(
          onBack: toWelcome,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s4,
            children: [
              const Center(child: AuthIconDisc(AppAssets.lock)),
              AuthHeading(
                l10n.resetTitle,
                subtitle: l10n.resetSubtitle(BrandConfig.name),
              ),
              AuthField(
                label: l10n.resetNewPasswordLabel,
                controller: _password,
                obscure: _obscured,
                autofocus: true,
                hasError: commonFailed,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                onChanged: cubit.passwordChanged,
                onSubmitted: (_) => cubit.submit(_password.text),
                suffix: PasswordVisibilityButton(
                  obscured: _obscured,
                  onToggle: () => setState(() => _obscured = !_obscured),
                ),
              ),
              ListenableBuilder(
                listenable: _password,
                builder: (context, _) => PasswordChecklist(
                  problems: state.problems,
                  hasInput: _password.text.isNotEmpty,
                  serverChecked: state.serverChecked,
                ),
              ),
              if (error != null && error != AuthError.passwordCommon)
                AuthErrorBanner(error),
            ],
          ),
          actions: ListenableBuilder(
            listenable: _password,
            builder: (context, _) => AppButton(
              label: l10n.resetSave,
              loading: state.busy,
              loadingLabel: l10n.authBusySaving,
              onPressed:
                  _password.text.isEmpty ||
                      state.problems.contains(PasswordProblem.tooShort) ||
                      state.problems.contains(PasswordProblem.noSymbol)
                  ? null
                  : () => cubit.submit(_password.text),
            ),
          ),
        );
      },
    );
  }
}
