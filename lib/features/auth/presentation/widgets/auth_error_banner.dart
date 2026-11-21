import 'package:material_ui/material_ui.dart';

import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_error.dart';
import 'auth_banner.dart';
import 'auth_error_text.dart';

/// The banner for a failed call. Not being able to connect is nobody's fault,
/// so it is neutral (sky, info icon); everything else is a real error.
class const AuthErrorBanner(
  final AuthError error, {
  final VoidCallback? onRetry,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final neutral = error == AuthError.offline || error == AuthError.timeout;
    return AuthBanner(
      error.message(l10n),
      kind: neutral ? AuthBannerKind.info : AuthBannerKind.danger,
      actionLabel: neutral && onRetry != null ? l10n.authTryAgain : null,
      onAction: neutral ? onRetry : null,
    );
  }
}
