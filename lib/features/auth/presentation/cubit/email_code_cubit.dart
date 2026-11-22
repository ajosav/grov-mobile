import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/code_verification.dart';
import '../../domain/usecases/request_sign_in_code.dart';
import '../../domain/usecases/verify_sign_in_code.dart';
import 'auth_error.dart';
import 'email_code_state.dart';
import 'safe_emit.dart';

/// The 6-digit sign-in code. Screen-scoped: created by the code route.
class EmailCodeCubit({
  required final VerifySignInCode _verifyCode,
  required final RequestSignInCode _requestCode,
  required final String email,
  final DateTime? nextSendAt,
}) extends Cubit<EmailCodeState> with SafeEmit<EmailCodeState> {
  this : super(EmailCodeState(email: email, nextSendAt: nextSendAt));

  static const length = 6;

  void codeChanged(String raw) {
    if (state.status == EmailCodeStatus.verifying ||
        state.status == EmailCodeStatus.locked ||
        state.status == EmailCodeStatus.accepted) {
      return;
    }
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final code = digits.length > length ? digits.substring(0, length) : digits;
    emit(state.copyWith(code: code, error: null));
    if (code.length == length) {
      verify();
    }
  }

  Future<void> verify() async {
    if (state.code.length != length ||
        state.status != EmailCodeStatus.entering) {
      return;
    }
    emit(state.copyWith(status: EmailCodeStatus.verifying, error: null));
    switch (await _verifyCode((email: state.email, code: state.code))) {
      case Ok(:final value):
        switch (value) {
          case CodeSignedIn(:final outcome):
            final session = outcome.session;
            if (session == null) {
              emit(
                state.copyWith(
                  status: EmailCodeStatus.entering,
                  error: AuthError.unsupportedStep,
                ),
              );
              return;
            }
            emit(
              state.copyWith(
                status: EmailCodeStatus.accepted,
                verifiedSession: session,
              ),
            );
          case CodeProfileRequired(:final ticket):
            emit(
              state.copyWith(
                status: EmailCodeStatus.accepted,
                profileTicket: ticket,
              ),
            );
        }
      case Err(:final failure):
        final error = authErrorOf(failure);
        emit(
          state.copyWith(
            status: error == AuthError.codeLocked
                ? EmailCodeStatus.locked
                : EmailCodeStatus.entering,
            error: error,
          ),
        );
    }
  }

  Future<void> resend() async {
    if (state.resending || state.status == EmailCodeStatus.verifying) {
      return;
    }
    emit(state.copyWith(resending: true, error: null));
    switch (await _requestCode(state.email)) {
      case Ok(:final value):
        emit(
          state.copyWith(
            resending: false,
            code: '',
            status: EmailCodeStatus.entering,
            nextSendAt: value.nextSendAt,
          ),
        );
      case Err(:final failure):
        emit(
          state.copyWith(
            resending: false,
            nextSendAt: nextSendAtOf(failure) ?? state.nextSendAt,
            error: authErrorOf(failure),
          ),
        );
    }
  }
}
