import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/nigerian_phone.dart';
import '../../domain/usecases/complete_phone.dart';
import 'auth_error.dart';
import 'safe_emit.dart';
import 'phone_state.dart';

class PhoneCubit(final CompletePhone _completePhone)
    extends Cubit<PhoneState>
    with SafeEmit<PhoneState> {
  this : super(const PhoneState());

  void phoneEdited() {
    if (state.error != null) {
      emit(state.copyWith(error: null));
    }
  }

  Future<void> submit(String phone) async {
    if (state.busy) {
      return;
    }
    final normalised = normalizeNigerianPhone(phone);
    if (normalised == null) {
      emit(state.copyWith(error: AuthError.phoneInvalid));
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    switch (await _completePhone(normalised)) {
      case Ok(:final value):
        final session = value.session;
        emit(
          session == null
              ? state.copyWith(busy: false, error: AuthError.unsupportedStep)
              : state.copyWith(busy: false, signedInSession: session),
        );
      case Err(:final failure):
        emit(state.copyWith(busy: false, error: authErrorOf(failure)));
    }
  }
}
