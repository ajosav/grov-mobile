import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/password_policy.dart';
import '../../domain/usecases/check_password.dart';
import '../../domain/usecases/check_reset_link.dart';
import '../../domain/usecases/reset_password.dart';
import 'auth_error.dart';
import 'safe_emit.dart';
import 'live_password_check.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit({
  required final CheckResetLink _checkResetLink,
  required final ResetPassword _resetPassword,
  required CheckPassword checkPassword,
  required final String token,
}) extends Cubit<ResetPasswordState> with SafeEmit<ResetPasswordState> {
  this
    : _live = LivePasswordCheck(checkPassword),
      super(const ResetPasswordState());

  final LivePasswordCheck _live;

  Future<void> load() async {
    // The API's tokens are at least 20 characters; anything shorter is a
    // mangled link, not worth a request.
    if (token.length < 20) {
      emit(state.copyWith(link: ResetLinkStatus.dead));
      return;
    }
    switch (await _checkResetLink(token)) {
      case Ok(:final value):
        emit(
          state.copyWith(
            link: value ? ResetLinkStatus.ready : ResetLinkStatus.dead,
          ),
        );
      case Err(:final failure):
        final error = authErrorOf(failure);
        // Offline is not a dead link: keep the form and let submit retry.
        emit(
          state.copyWith(
            link: error == AuthError.linkExpired || error == AuthError.linkUsed
                ? ResetLinkStatus.dead
                : ResetLinkStatus.ready,
          ),
        );
    }
  }

  void passwordChanged(String password) => _live.update(
    password,
    onResult: (problems, serverChecked) => emit(
      state.copyWith(
        problems: problems,
        serverChecked: serverChecked,
        error: null,
      ),
    ),
  );

  Future<void> submit(String password) async {
    if (state.busy || localPasswordProblems(password).isNotEmpty) {
      return;
    }
    emit(state.copyWith(busy: true, error: null));
    switch (await _resetPassword((token: token, password: password))) {
      case Ok(:final value):
        final session = value.session;
        emit(
          session == null
              ? state.copyWith(busy: false, error: AuthError.unsupportedStep)
              : state.copyWith(busy: false, signedInSession: session),
        );
      case Err(:final failure):
        final error = authErrorOf(failure);
        emit(
          state.copyWith(
            busy: false,
            error: error,
            link: error == AuthError.linkExpired || error == AuthError.linkUsed
                ? ResetLinkStatus.dead
                : state.link,
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _live.dispose();
    return super.close();
  }
}
