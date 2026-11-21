import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/time_format.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../l10n/app_localizations.dart';
import '../cubit/sync_status_cubit.dart';
import '../cubit/sync_status_state.dart';

/// "Synced 7:40am" with a green dot, or "Offline · last synced 7:40am" with a
/// hollow dot.
class const SyncStatusLine({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = context.tokens;
    return BlocBuilder<SyncStatusCubit, SyncStatusState>(
      builder: (context, state) {
        final at = state.lastSyncedAt;
        final label = switch ((state.online, at)) {
          (true, final DateTime t) => l10n.syncedAt(formatClockWat(t)),
          (true, null) => l10n.neverSynced,
          (false, final DateTime t) => l10n.offlineLastSynced(
            formatClockWat(t),
          ),
          (false, null) => l10n.offlineNeverSynced,
        };
        return Semantics(
          liveRegion: true,
          label: label,
          child: ExcludeSemantics(
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.online ? c.leaf : Colors.transparent,
                    border: state.online
                        ? null
                        : Border.all(color: c.inkMuted, width: 1.5),
                  ),
                  child: const SizedBox.square(dimension: 8),
                ),
                const SizedBox(width: AppSpace.s2),
                Flexible(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: c.inkMuted),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
