import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;

/// Section title with an optional trailing link ("View all").
class const SectionHeader(
  final String title, {
  final String? linkLabel,
  final VoidCallback? onLink,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final c = context.tokens;
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(title, style: text.titleLarge),
          ),
        ),
        if (linkLabel != null)
          InkWell(
            onTap: onLink,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: AppSize.touchMin),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    linkLabel!,
                    style: text.labelLarge?.copyWith(color: c.flameStrong),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.chevron_right,
                    size: AppSize.iconSm,
                    color: c.flameStrong,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
