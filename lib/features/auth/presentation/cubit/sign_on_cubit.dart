import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/email_format.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/new_profile.dart';
import '../../domain/nigerian_phone.dart';
import '../../domain/usecases/complete_profile.dart';
import '../../domain/usecases/get_terms_version.dart';
import '../../domain/usecases/request_sign_in_code.dart';
import 'auth_error.dart';
import 'safe_emit.dart';
import 'sign_on_effect.dart';
import 'sign_on_state.dart';

/// Shared by Welcome and the profile screen (shell-scoped): the email being
/// signed in, the request for its code, and creating a new account.
class SignOnCubit({
  required final RequestSignInCode _requestCode,
  required final CompleteProfile _completeProfile,
  required final GetTermsVersion _getTermsVersion,
}) extends Cubit<SignOnState> with SafeEmit<SignOnState> {
  this : super(const SignOnState());

  void emailChanged(String value) =>
      emit(state.copyWith(email: value.trim(), error: null));

  Future<void> loadTermsVersion() async {
    if (state.termsLoading) {
      return;
    }
    emit(
      state.copyWith(
        termsLoading: true,
        termsVersion: null,
        termsAccepted: false,
        error: null,
      ),
    );
    switch (await _getTermsVersion(const NoParams())) {
      case Ok(:final value) when value.trim().isNotEmpty:
        emit(state.copyWith(termsLoading: false, termsVersion: value));
      case Ok():
        emit(state.copyWith(termsLoading: false, error: AuthError.unknown));
      case Err(:final failure):
        emit(state.copyWith(termsLoading: false, error: authErrorOf(failure)));
    }
  }

  void setTermsAccepted(bool accepted) {
    if (state.termsVersion == null || state.termsLoading) {
      return;
    }
    emit(state.copyWith(termsAccepted: accepted));
  }

  /// Asks for the code. A new and an existing address get the same answer; a
  /// "too soon" answer still opens the code screen, since a code is on its way.
  Future<void> continueWithEmail() async {
    if (state.busy) {
      return;
    }
    if (!isPlausibleEmail(state.email)) {
      emit(state.copyWith(error: AuthError.invalidEmail));
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    switch (await _requestCode(state.email)) {
      case Ok(:final value):
        emit(
          state.copyWith(
            busy: false,
            codeNextSendAt: value.nextSendAt,
            effect: const SignOnEffect.toCode(),
          ),
        );
      case Err(:final failure):
        final nextSendAt = nextSendAtOf(failure);
        if (authErrorOf(failure) == AuthError.resendTooSoon &&
            nextSendAt != null) {
          emit(
            state.copyWith(
              busy: false,
              codeNextSendAt: nextSendAt,
              effect: const SignOnEffect.toCode(),
            ),
          );
          return;
        }
        emit(state.copyWith(busy: false, error: authErrorOf(failure)));
    }
  }

  Future<void> completeProfile({
    required String ticket,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final termsVersion = state.termsVersion;
    if (state.busy ||
        termsVersion == null ||
        !state.termsAccepted ||
        state.termsLoading) {
      return;
    }
    final normalised = normalizeNigerianPhone(phone);
    if (normalised == null) {
      emit(state.copyWith(error: AuthError.phoneInvalid));
      return;
    }
    if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    final result = await _completeProfile(
      NewProfile(
        ticket: ticket,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        phone: normalised,
        termsVersion: termsVersion,
      ),
    );
    if (result case Err(:final failure)
        when authErrorOf(failure) == AuthError.termsStale) {
      emit(
        state.copyWith(
          busy: false,
          error: AuthError.termsStale,
          termsVersion: null,
          termsAccepted: false,
        ),
      );
      return;
    }
    _finish(result);
  }

  void clearError() => emit(state.copyWith(error: null));

  /// The page acted on the effect. Also ends `signingIn` (the full-screen
  /// transition), which runs from the server's yes until the session is saved.
  void effectHandled() => emit(state.copyWith(effect: null, signingIn: false));

  void _finish(Result<AuthOutcome> result) {
    switch (result) {
      case Ok(:final value):
        final session = value.session;
        if (session == null) {
          emit(state.copyWith(busy: false, error: AuthError.unsupportedStep));
          return;
        }
        emit(
          state.copyWith(
            busy: false,
            // The transition covers the screen while the session is saved.
            signingIn: true,
            effect: SignOnEffect.signedIn(session),
          ),
        );
      case Err(:final failure):
        emit(state.copyWith(busy: false, error: authErrorOf(failure)));
    }
  }
}
