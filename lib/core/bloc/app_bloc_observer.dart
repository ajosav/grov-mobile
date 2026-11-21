import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

/// Debug builds only; release never installs it.
class AppBlocObserver() extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('[bloc] ${bloc.runtimeType} error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    debugPrint('[bloc] ${bloc.runtimeType} ${transition.event.runtimeType}');
    super.onTransition(bloc, transition);
  }
}
