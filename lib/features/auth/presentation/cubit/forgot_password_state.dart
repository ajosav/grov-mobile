import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_error.dart';

part 'forgot_password_state.freezed.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default(false) bool busy,
    AuthError? error,
    DateTime? nextSendAt,

    @Default(false) bool sent,
  }) = _ForgotPasswordState;
}
