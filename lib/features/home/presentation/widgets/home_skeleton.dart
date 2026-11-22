import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/skeleton.dart';
import '../../../../l10n/app_localizations.dart';

/// Ghost of the Home page: same blocks, same spacing, so nothing jumps when
/// the real content arrives.
class const HomeSkeleton({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return Skeleton(
      label: AppLocalizations.of(context).homeLoadingLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpace.s2),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: 90, height: 30),
                    SizedBox(height: AppSpace.s2),
                    SkeletonBox(width: 220, height: 24),
                    SizedBox(height: AppSpace.s2),
                    SkeletonBox(width: 180, height: 16),
                  ],
                ),
              ),
              SkeletonCircle(),
              SizedBox(width: AppSpace.s3),
              SkeletonCircle(),
            ],
          ),
          const SizedBox(height: AppSpace.s4),
          // Progress card: a night block, as the real card is.
          SizedBox(
            height: 156,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: c.surfaceSunken,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
          ),
          const SizedBox(height: AppSpace.s6),
          const SkeletonBox(width: 180, height: 24),
          const SizedBox(height: AppSpace.s3),
          const _Row(photo: true),
          const SizedBox(height: AppSpace.s3),
          const _Row(),
          const SizedBox(height: AppSpace.s6),
          const SkeletonBox(width: 140, height: 24),
          const SizedBox(height: AppSpace.s3),
          const Row(
            spacing: 10,
            children: [
              Expanded(child: SkeletonBox(height: 98, radius: AppRadius.md)),
              Expanded(child: SkeletonBox(height: 98, radius: AppRadius.md)),
              Expanded(child: SkeletonBox(height: 98, radius: AppRadius.md)),
              Expanded(child: SkeletonBox(height: 98, radius: AppRadius.md)),
            ],
          ),
        ],
      ),
    );
  }
}

class const _Row({final bool photo = false}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    spacing: AppSpace.s3,
    children: [
      if (photo)
        const SkeletonBox(width: 96, height: 84, radius: AppRadius.md)
      else
        const SkeletonBox(width: 44, height: 44, radius: AppRadius.md),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(height: 17),
            SizedBox(height: AppSpace.s2),
            SkeletonBox(width: 120, height: 12),
          ],
        ),
      ),
    ],
  );
}
