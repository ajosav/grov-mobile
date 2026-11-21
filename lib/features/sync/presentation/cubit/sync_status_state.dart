import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_status_state.freezed.dart';

@freezed
abstract class SyncStatusState with _$SyncStatusState {
  const factory SyncStatusState({
    /// Optimistic default: no banner flashes before the first reading.
    @Default(true) bool online,
    DateTime? lastSyncedAt,
  }) = _SyncStatusState;
}
