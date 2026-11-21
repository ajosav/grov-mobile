import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/email_format.dart';
import '../../domain/usecases/request_password_reset.dart';
import 'auth_error.dart';
import 'safe_emit.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit(
  final RequestPasswordReset _requestPasswordReset, {
  final String email = '',
}) extends Cubit<ForgotPasswordState> with SafeEmit<ForgotPasswordState> {
  this : super(ForgotPasswordState(email: email));

  void emailChanged(String value) =>
      emit(state.copyWith(email: value.trim(), error: null));

  Future<void> send() async {
    if (state.busy) {
      return;
    }
    if (!isPlausibleEmail(state.email)) {
      emit(state.copyWith(error: AuthError.invalidEmail));
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    switch (await _requestPasswordReset(state.email)) {
      case Ok(:final value):
        emit(state.copyWith(busy: false, sent: true, nextSendAt: value));
      case Err(:final failure):
        emit(
          state.copyWith(
            busy: false,
            nextSendAt: nextSendAtOf(failure) ?? state.nextSendAt,
            error: authErrorOf(failure),
          ),
        );
    }
  }

  /// The page has moved to "Check your email".
  void sentHandled() => emit(state.copyWith(sent: false));
}
