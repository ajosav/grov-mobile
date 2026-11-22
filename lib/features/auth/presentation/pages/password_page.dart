import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/sign_on_cubit.dart';
import '../cubit/sign_on_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_visibility_button.dart';
import 'sign_on_effects.dart';

/// "Welcome back": the email is known to have a password.
class const PasswordView({super.key}) extends StatefulWidget {
  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState() extends State<PasswordView> {
  final _password = TextEditingController();
  late final TextEditingController _email;
  var _obscured = true;

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
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SignOnCubit>();
    return BlocConsumer<SignOnCubit, SignOnState>(
      listenWhen: (a, b) => b.effect != null && a.effect != b.effect,
      listener: handleSignOnEffect,
      buildWhen: (a, b) => a.busy != b.busy || a.error != b.error,
      builder: (context, state) {
        final error = state.error;
        return AuthScaffold(
          onBack: context.pop,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s4,
            children: [
              const Center(child: AuthIconDisc(AppAssets.lock)),
              AuthHeading(l10n.passwordTitle, subtitle: l10n.passwordSubtitle),
              if (error != null)
                AuthErrorBanner(
                  error,
                  serverMessage: state.serverErrorMessage,
                  retryAt: state.retryAt,
                  onRetryAvailable: cubit.retryAvailable,
                ),
              AuthField(
                label: l10n.authEmailLabel,
                controller: _email,
                readOnly: true,
                suffix: AuthLink(l10n.authChange, onTap: context.pop),
              ),
              AuthField(
                label: l10n.authPasswordLabel,
                controller: _password,
                hint: l10n.authPasswordHint,
                obscure: _obscured,
                autofocus: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                onChanged: (_) {
                  if (state.error != null) cubit.clearError();
                },
                onSubmitted: (_) => cubit.logIn(_password.text),
                suffix: PasswordVisibilityButton(
                  obscured: _obscured,
                  onToggle: () => setState(() => _obscured = !_obscured),
                ),
              ),
              Center(
                child: AuthLink(
                  l10n.authForgotLink,
                  onTap: () => context.push(Routes.forgot),
                ),
              ),
            ],
          ),
          actions: ListenableBuilder(
            listenable: _password,
            builder: (context, _) => AppButton(
              label: l10n.authLogIn,
              loading: state.busy,
              loadingLabel: l10n.authBusySigningIn,
              onPressed: _password.text.isEmpty ||
                      (state.retryAt?.isAfter(DateTime.now()) ?? false)
                  ? null
                  : () => cubit.logIn(_password.text),
            ),
          ),
        );
      },
    );
  }
}
