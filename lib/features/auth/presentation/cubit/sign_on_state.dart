import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/account_lookup.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/entities/password_problem.dart';
import 'auth_error.dart';
import 'sign_on_effect.dart';

part 'sign_on_state.freezed.dart';

@freezed
abstract class SignOnState with _$SignOnState {
  const factory SignOnState({
    @Default('') String email,
    AccountLookup? lookup,
    @Default(false) bool busy,

    /// A sign-in succeeded and the app is moving on: the full-screen transition.
    @Default(false) bool signingIn,
    String? termsVersion,
    @Default(false) bool termsLoading,
    @Default(false) bool termsAccepted,
    @Default(<PasswordProblem>{}) Set<PasswordProblem> passwordProblems,

    /// True once the server has confirmed the checklist (not just local rules).
    @Default(false) bool passwordServerChecked,
    AuthError? error,
    String? serverErrorMessage,
    DateTime? retryAt,

    /// The code sent by sign-up, so the code screen can start its countdown.
    OtpChallenge? challenge,
    SignOnEffect? effect,
  }) = _SignOnState;
}
