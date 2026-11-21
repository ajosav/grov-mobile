import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/password_problem.dart';
import '../cubit/auth_error.dart';
import '../cubit/sign_on_cubit.dart';
import '../cubit/sign_on_state.dart';
import '../widgets/auth_banner.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_error_text.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/password_checklist.dart';
import '../widgets/password_visibility_button.dart';
import 'sign_on_effects.dart';

/// "Let's set you up": first name, phone and password for a new email.
class const JoinView({super.key}) extends StatefulWidget {
  @override
  State<JoinView> createState() => _JoinViewState();
}

class _JoinViewState() extends State<JoinView> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
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
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() => context.read<SignOnCubit>().signUp(
    firstName: _firstName.text,
    lastName: _lastName.text,
    phone: _phone.text,
    password: _password.text,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.tokens;
    final cubit = context.read<SignOnCubit>();
    return BlocConsumer<SignOnCubit, SignOnState>(
      listenWhen: (a, b) => b.effect != null && a.effect != b.effect,
      listener: handleSignOnEffect,
      buildWhen: (a, b) =>
          a.busy != b.busy ||
          a.error != b.error ||
          a.passwordProblems != b.passwordProblems ||
          a.passwordServerChecked != b.passwordServerChecked,
      builder: (context, state) {
        final error = state.error;
        final phoneError =
            error == AuthError.phoneTaken || error == AuthError.phoneInvalid;
        final commonFailed =
            error == AuthError.passwordCommon ||
            state.passwordProblems.contains(PasswordProblem.common) ||
            state.passwordProblems.contains(PasswordProblem.emailLocalPart);
        final banner = switch (error) {
          null ||
          AuthError.emailTaken ||
          AuthError.phoneTaken ||
          AuthError.phoneInvalid ||
          AuthError.passwordCommon => null,
          _ => error,
        };
        return AuthScaffold(
          onBack: context.pop,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s3,
            children: [
              AuthHeading(l10n.joinTitle, subtitle: l10n.joinSubtitle),
              if (error == AuthError.emailTaken)
                AuthBanner(
                  error!.message(l10n),
                  actionLabel: l10n.authLogIn,
                  onAction: cubit.logInInstead,
                ),
              AuthField(
                label: l10n.authEmailLabel,
                controller: _email,
                readOnly: true,
                suffix: AuthLink(l10n.authChange, onTap: context.pop),
              ),
              AuthField(
                label: l10n.authFirstNameLabel,
                controller: _firstName,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.givenName],
              ),
              AuthField(
                label: l10n.authLastNameLabel,
                controller: _lastName,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.familyName],
              ),
              AuthField(
                label: l10n.authPhoneLabel,
                controller: _phone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.telephoneNumberNational],
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('+234', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(width: AppSpace.s3),
                    SizedBox(
                      height: 24,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: c.lineStrong,
                      ),
                    ),
                  ],
                ),
                hasError: phoneError,
                errorText: phoneError ? error!.message(l10n) : null,
                helper: l10n.authPhoneHelper,
                onChanged: (_) {
                  if (phoneError) cubit.clearError();
                },
              ),
              AuthField(
                label: l10n.authPasswordLabel,
                controller: _password,
                obscure: _obscured,
                hasError: commonFailed,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                onChanged: cubit.passwordChanged,
                onSubmitted: (_) => _submit(),
                suffix: PasswordVisibilityButton(
                  obscured: _obscured,
                  onToggle: () => setState(() => _obscured = !_obscured),
                ),
              ),
              ListenableBuilder(
                listenable: _password,
                builder: (context, _) => PasswordChecklist(
                  problems: state.passwordProblems,
                  hasInput: _password.text.isNotEmpty,
                  serverChecked: state.passwordServerChecked,
                ),
              ),
              if (banner != null) AuthErrorBanner(banner),
            ],
          ),
          actions: ListenableBuilder(
            listenable: Listenable.merge([_firstName, _phone, _password]),
            builder: (context, _) {
              final ready =
                  _firstName.text.trim().isNotEmpty &&
                  _phone.text.trim().isNotEmpty &&
                  _password.text.isNotEmpty &&
                  !state.passwordProblems.contains(PasswordProblem.tooShort) &&
                  !state.passwordProblems.contains(PasswordProblem.noSymbol);
              return AppButton(
                label: l10n.authCreateAccount,
                loading: state.busy,
                onPressed: ready ? _submit : null,
              );
            },
          ),
        );
      },
    );
  }
}
