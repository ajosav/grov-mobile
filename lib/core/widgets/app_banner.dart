import 'package:material_ui/material_ui.dart';

import '../theme/app_tokens.dart' hide formatNaira;

/// Neutral note. Offline uses this sunken style, not info blue and never
/// red: the user did nothing wrong.
class const AppBanner({
  required final String title,
  final String? body,
  final IconData icon = Icons.cloud_off_outlined,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    final text = Theme.of(context).textTheme;
    return Semantics(
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: c.surfaceSunken,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.s4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: AppSize.iconMd, color: c.inkMuted),
              const SizedBox(width: AppSpace.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: text.titleSmall),
                    if (body != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        body!,
                        style: text.bodyMedium?.copyWith(color: c.inkMuted),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
