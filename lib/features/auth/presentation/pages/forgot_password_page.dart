import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_error.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_error_text.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_link.dart';
import '../widgets/auth_scaffold.dart';

/// Step one of a reset: the email to send the link to.
class const ForgotPasswordView({super.key}) extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState() extends State<ForgotPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(
      text: context.read<ForgotPasswordCubit>().state.email,
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
    final cubit = context.read<ForgotPasswordCubit>();
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (a, b) => !a.sent && b.sent,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          context.push(Routes.forgotSent);
        }
      },
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
              AuthHeading(l10n.forgotTitle, subtitle: l10n.forgotSubtitle),
              AuthField(
                label: l10n.authEmailLabel,
                controller: _email,
                hint: l10n.authEmailHint,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.send,
                autofillHints: const [AutofillHints.email],
                hasError: error == AuthError.invalidEmail,
                errorText: error == AuthError.invalidEmail
                    ? error!.message(l10n)
                    : null,
                onChanged: cubit.emailChanged,
                onSubmitted: (_) => cubit.send(),
              ),
              if (error != null && error != AuthError.invalidEmail)
                AuthErrorBanner(error),
            ],
          ),
          actions: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s3,
            children: [
              AppButton(
                label: l10n.forgotSend,
                loading: state.busy,
                loadingLabel: l10n.authBusySending,
                onPressed: cubit.send,
              ),
              Center(child: AuthLink(l10n.forgotBack, onTap: context.pop)),
            ],
          ),
        );
      },
    );
  }
}
