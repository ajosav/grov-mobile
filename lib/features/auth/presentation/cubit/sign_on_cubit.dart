import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/email_format.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/new_account.dart';
import '../../domain/nigerian_phone.dart';
import '../../domain/password_policy.dart';
import '../../domain/usecases/check_password.dart';
import '../../domain/usecases/log_in.dart';
import '../../domain/usecases/lookup_account.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_error.dart';
import 'safe_emit.dart';
import 'live_password_check.dart';
import 'sign_on_effect.dart';
import 'sign_on_state.dart';

class SignOnCubit({
  required final LookupAccount _lookupAccount,
  required final LogIn _logIn,
  required final SignUp _signUp,
  required CheckPassword checkPassword,
}) extends Cubit<SignOnState> with SafeEmit<SignOnState> {
  this : _live = LivePasswordCheck(checkPassword), super(const SignOnState());

  final LivePasswordCheck _live;

  void emailChanged(String value) =>
      emit(state.copyWith(email: value.trim(), error: null));

  Future<void> continueWithEmail() async {
    if (state.busy) {
      return;
    }
    if (!isPlausibleEmail(state.email)) {
      emit(state.copyWith(error: AuthError.invalidEmail));
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    switch (await _lookupAccount(state.email)) {
      case Ok(:final value):
        emit(
          state.copyWith(
            busy: false,
            lookup: value,
            error: value.exists && !value.hasPassword
                ? AuthError.socialOnly
                : null,
            effect: !value.exists
                ? const SignOnEffect.toJoin()
                : value.hasPassword
                ? const SignOnEffect.toPassword()
                : null,
          ),
        );
      case Err(:final failure):
        emit(state.copyWith(busy: false, error: authErrorOf(failure)));
    }
  }

  Future<void> logIn(String password) async {
    if (state.busy || password.isEmpty) {
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    _finish(await _logIn((email: state.email, password: password)));
  }

  void passwordChanged(String password) => _live.update(
    password,
    email: state.email,
    onResult: (problems, serverChecked) => emit(
      state.copyWith(
        passwordProblems: problems,
        passwordServerChecked: serverChecked,
        error: null,
      ),
    ),
  );

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  }) async {
    if (state.busy) {
      return;
    }
    final normalised = normalizeNigerianPhone(phone);
    if (normalised == null) {
      emit(state.copyWith(error: AuthError.phoneInvalid));
      return;
    }
    if (firstName.trim().isEmpty ||
        localPasswordProblems(password).isNotEmpty) {
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    _finish(
      await _signUp(
        NewAccount(
          email: state.email,
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          phone: normalised,
          password: password,
        ),
      ),
    );
  }

  void logInInstead() => emit(
    state.copyWith(error: null, effect: const SignOnEffect.toPassword()),
  );

  void clearError() => emit(state.copyWith(error: null));

  void effectHandled() => emit(state.copyWith(effect: null));

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
            challenge: value.challenge,
            effect: SignOnEffect.signedIn(session),
          ),
        );
      case Err(:final failure):
        emit(state.copyWith(busy: false, error: authErrorOf(failure)));
    }
  }

  @override
  Future<void> close() {
    _live.dispose();
    return super.close();
  }
}
