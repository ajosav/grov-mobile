import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/platform/clock.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/watch_home.dart';
import 'home_state.dart';

class HomeCubit({
  required final WatchHome _watchHome,
  required final Clock _clock,
}) extends Cubit<HomeState> {
  this : super(const HomeState.loading());

  StreamSubscription<dynamic>? _subscription;

  /// Start (or restart, after a failure) listening. Data already on screen is
  /// kept when a refresh fails: only an empty screen shows the failure state.
  Future<void> load() async {
    // Not awaited: starting over must not wait on the old stream to wind down.
    unawaited(_subscription?.cancel());
    if (state is HomeFailure) {
      emit(const HomeState.loading());
    }
    _subscription = _watchHome(const NoParams()).listen((result) {
      result.when(
        ok: (summary) =>
            emit(HomeState.data(summary: summary, period: _period())),
        err: (_) {
          if (state is! HomeData) {
            emit(const HomeState.failure());
          }
        },
      );
    });
  }

  GreetingPeriod _period() {
    final hour = _clock.now().hour;
    if (hour < 12) {
      return GreetingPeriod.morning;
    }
    return hour < 17 ? GreetingPeriod.afternoon : GreetingPeriod.evening;
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
