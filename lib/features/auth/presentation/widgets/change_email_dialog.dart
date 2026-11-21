import 'package:material_ui/material_ui.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/email_format.dart';
import 'auth_field.dart';

/// Asks for the corrected email while the account is still unverified.
/// Pops with the new address, or null on cancel.
class const ChangeEmailDialog({super.key}) extends StatefulWidget {
  @override
  State<ChangeEmailDialog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState() extends State<ChangeEmailDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.changeEmailTitle),
      content: AuthField(
        label: l10n.authEmailLabel,
        controller: _controller,
        hint: l10n.authEmailHint,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.email],
        onSubmitted: (_) => _save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.changeEmailCancel),
        ),
        FilledButton(onPressed: _save, child: Text(l10n.changeEmailSave)),
      ],
    );
  }

  void _save() {
    final email = _controller.text.trim();
    if (isPlausibleEmail(email)) {
      Navigator.of(context).pop(email);
    }
  }
}
