import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_progress.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/registration_ticket.dart';
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
import 'sign_on_effects.dart';

/// "Tell us about you": the first name, last name and phone of a new address.
/// The code already verified the email, so there is no second code here.
class const ProfileView(final RegistrationTicket ticket, {super.key})
    extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState() extends State<ProfileView> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(
      text: context.read<SignOnCubit>().state.email,
    );
    context.read<SignOnCubit>().loadTermsVersion();
  }

  @override
  void dispose() {
    _email.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() => context.read<SignOnCubit>().completeProfile(
    ticket: widget.ticket.ticket,
    firstName: _firstName.text,
    lastName: _lastName.text,
    phone: _phone.text,
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
          a.termsVersion != b.termsVersion ||
          a.termsLoading != b.termsLoading ||
          a.termsAccepted != b.termsAccepted,
      builder: (context, state) {
        final error = state.error;
        final termsError = state.termsVersion == null && !state.termsLoading
            ? error
            : null;
        final phoneError =
            error == AuthError.phoneTaken || error == AuthError.phoneInvalid;
        final banner = switch (error) {
          null ||
          AuthError.emailTaken ||
          AuthError.phoneTaken ||
          AuthError.phoneInvalid ||
          AuthError.termsStale => null,
          _ => error,
        };
        return AuthScaffold(
          onBack: () => context.go(Routes.welcome),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s3,
            children: [
              AuthHeading(l10n.profileTitle, subtitle: l10n.profileSubtitle),
              if (error == AuthError.emailTaken)
                AuthBanner(
                  error!.message(l10n),
                  actionLabel: l10n.codeChangeEmail,
                  onAction: () => context.go(Routes.welcome),
                ),
              if (error == AuthError.ticketExpired)
                AuthBanner(
                  error!.message(l10n),
                  actionLabel: l10n.authContinue,
                  onAction: () => context.go(Routes.welcome),
                ),
              AuthField(
                label: l10n.authEmailLabel,
                controller: _email,
                readOnly: true,
                suffix: AuthLink(
                  l10n.authChange,
                  onTap: () => context.go(Routes.welcome),
                ),
              ),
              AuthField(
                label: l10n.authFirstNameLabel,
                controller: _firstName,
                autofocus: true,
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
                textInputAction: TextInputAction.done,
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
                onSubmitted: (_) => _submit(),
              ),
              if (state.termsLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpace.s2,
                  children: [
                    AppProgress(size: 18, semanticLabel: l10n.authTermsLoading),
                    Flexible(
                      child: Text(
                        l10n.authTermsLoading,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: state.termsAccepted,
                onChanged: state.termsVersion == null || state.termsLoading
                    ? null
                    : (accepted) => cubit.setTermsAccepted(accepted ?? false),
                title: Text(l10n.authTermsAcceptance),
              ),
              if (termsError != null)
                AuthBanner(
                  termsError.message(l10n),
                  kind:
                      termsError == AuthError.offline ||
                          termsError == AuthError.timeout
                      ? AuthBannerKind.info
                      : AuthBannerKind.danger,
                  actionLabel: l10n.authTryAgain,
                  onAction: cubit.loadTermsVersion,
                ),
              if (banner != null && banner != AuthError.ticketExpired)
                AuthErrorBanner(banner),
            ],
          ),
          actions: ListenableBuilder(
            listenable: Listenable.merge([_firstName, _lastName, _phone]),
            builder: (context, _) {
              final ready =
                  _firstName.text.trim().isNotEmpty &&
                  _lastName.text.trim().isNotEmpty &&
                  _phone.text.trim().isNotEmpty &&
                  state.termsVersion != null &&
                  state.termsAccepted &&
                  !state.termsLoading;
              return AppButton(
                label: l10n.authCreateAccount,
                loading: state.busy,
                loadingLabel: l10n.authBusyCreating,
                onPressed: ready ? _submit : null,
              );
            },
          ),
        );
      },
    );
  }
}
