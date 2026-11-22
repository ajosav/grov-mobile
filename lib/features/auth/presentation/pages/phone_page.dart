import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import '../../../session/presentation/cubit/session_state.dart';
import '../cubit/phone_cubit.dart';
import '../cubit/phone_state.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_error_text.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_heading.dart';
import '../widgets/auth_icon_disc.dart';
import '../widgets/auth_scaffold.dart';
import '../cubit/auth_error.dart';

/// "One more step": the phone number a Google or Apple account still owes.
class const PhoneView({super.key}) extends StatefulWidget {
  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState() extends State<PhoneView> {
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.tokens;
    final cubit = context.read<PhoneCubit>();
    final session = context.read<SessionCubit>();
    final email = switch (session.state) {
      SessionSignedIn(:final session) => session.email,
      _ => null,
    };
    return BlocConsumer<PhoneCubit, PhoneState>(
      listenWhen: (a, b) =>
          a.signedInSession == null && b.signedInSession != null,
      listener: (context, state) => session.signedIn(state.signedInSession!),
      builder: (context, state) {
        final error = state.error;
        final fieldError =
            error == AuthError.phoneInvalid || error == AuthError.phoneTaken;
        return AuthScaffold(
          onBack: session.signOut,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s4,
            children: [
              const Center(
                child: AuthIconDisc(
                  AppAssets.google,
                  iconSize: 24,
                  colorIcon: false,
                ),
              ),
              AuthHeading(l10n.phoneTitle, subtitle: l10n.phoneSubtitle),
              if (email != null)
                GlassCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.s4,
                    vertical: AppSpace.s3,
                  ),
                  radius: AppRadius.md,
                  child: Text(
                    email,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              AuthField(
                label: l10n.authPhoneLabel,
                controller: _phone,
                autofocus: true,
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
                hasError: fieldError,
                errorText: fieldError ? error!.message(l10n) : null,
                helper: l10n.authPhoneHelper,
                onChanged: (_) => cubit.phoneEdited(),
                onSubmitted: (_) => cubit.submit(_phone.text),
              ),
              if (error != null && !fieldError) AuthErrorBanner(error),
            ],
          ),
          actions: ListenableBuilder(
            listenable: _phone,
            builder: (context, _) => AppButton(
              label: l10n.authContinue,
              loading: state.busy,
              loadingLabel: l10n.authBusySaving,
              onPressed: _phone.text.trim().isEmpty
                  ? null
                  : () => cubit.submit(_phone.text),
              trailing: AppIcon(
                AppAssets.arrowRight,
                size: 18,
                color: _phone.text.trim().isEmpty
                    ? c.onActionDisabled
                    : c.onAction,
              ),
            ),
          ),
        );
      },
    );
  }
}
