import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmit<S> on Cubit<S> {
  @override
  void emit(S state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
