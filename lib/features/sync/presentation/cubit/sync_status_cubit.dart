import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_is_online.dart';
import '../../domain/usecases/watch_last_synced_at.dart';
import '../../domain/usecases/watch_online.dart';
import 'sync_status_state.dart';

/// Drives "Synced 7:40am" / "Offline · last synced 7:40am" and the offline
/// banner. Offline is never an error: nothing here is red.
class SyncStatusCubit({
  required final GetIsOnline _getIsOnline,
  required final WatchOnline _watchOnline,
  required final WatchLastSyncedAt _watchLastSyncedAt,
}) extends Cubit<SyncStatusState> {
  this : super(const SyncStatusState());

  StreamSubscription<dynamic>? _online;
  StreamSubscription<dynamic>? _synced;

  Future<void> start() async {
    final online = (await _getIsOnline(const NoParams())).valueOrNull;
    if (online != null) {
      emit(state.copyWith(online: online));
    }
    _online = _watchOnline(const NoParams()).listen((r) {
      final v = r.valueOrNull;
      if (v != null) {
        emit(state.copyWith(online: v));
      }
    });
    _synced = _watchLastSyncedAt(const NoParams()).listen((r) {
      // A failed read keeps the last known value.
      if (r.failureOrNull == null) {
        emit(state.copyWith(lastSyncedAt: r.valueOrNull));
      }
    });
  }

  @override
  Future<void> close() async {
    await _online?.cancel();
    await _synced?.cancel();
    return super.close();
  }
}
