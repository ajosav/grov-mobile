import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_error.dart';
import 'sign_on_effect.dart';

part 'sign_on_state.freezed.dart';

@freezed
abstract class SignOnState with _$SignOnState {
  const factory SignOnState({
    @Default('') String email,
    @Default(false) bool busy,

    /// A sign-in succeeded and the app is moving on: the full-screen transition.
    @Default(false) bool signingIn,
    String? termsVersion,
    @Default(false) bool termsLoading,
    @Default(false) bool termsAccepted,
    AuthError? error,

    /// When another code may be asked for, so the code screen can start its
    /// countdown. Set when the code was sent (or was already sent).
    DateTime? codeNextSendAt,
    SignOnEffect? effect,
  }) = _SignOnState;
}
