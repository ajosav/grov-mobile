import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';

class const OrDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final line = Expanded(child: Divider(color: c.lineStrong, height: 1));
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.s3),
          child: Text(
            AppLocalizations.of(context).authOr,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: c.inkMuted),
          ),
        ),
        line,
      ],
    );
  }
}
