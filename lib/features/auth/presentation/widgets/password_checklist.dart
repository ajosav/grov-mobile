import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/password_problem.dart';

/// The three live rules under a new password: length, a symbol, not a common
/// password. A rule is "met" only once there is input to judge; "common" waits
/// for the server's answer, so it never shows a green tick it has not earned.
class const PasswordChecklist({
  required final Set<PasswordProblem> problems,
  required final bool hasInput,
  required final bool serverChecked,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final commonFailed =
        problems.contains(PasswordProblem.common) ||
        problems.contains(PasswordProblem.emailLocalPart);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Row(
          l10n.authCheckLength,
          met: hasInput && !problems.contains(PasswordProblem.tooShort),
        ),
        const SizedBox(height: AppSpace.s2),
        _Row(
          l10n.authCheckSymbol,
          met: hasInput && !problems.contains(PasswordProblem.noSymbol),
        ),
        const SizedBox(height: AppSpace.s2),
        _Row(
          commonFailed ? l10n.authCheckCommonFailed : l10n.authCheckCommon,
          met: hasInput && serverChecked && !commonFailed,
          failed: commonFailed,
        ),
      ],
    );
  }
}

class const _Row(
  final String label, {
  required final bool met,
  final bool failed = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final color = failed ? c.danger : (met ? c.leafStrong : c.inkMuted);
    return Semantics(
      label: label,
      value: met ? 'met' : (failed ? 'not met' : ''),
      excludeSemantics: true,
      child: Row(
        children: [
          AppIcon(
            failed ? AppAssets.x : AppAssets.check,
            size: AppSize.iconSm,
            color: color,
          ),
          const SizedBox(width: AppSpace.s2),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: failed ? c.danger : (met ? c.ink : c.inkMuted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
