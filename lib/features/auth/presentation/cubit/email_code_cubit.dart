import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/change_email_address.dart';
import '../../domain/usecases/resend_email_code.dart';
import '../../domain/usecases/verify_email.dart';
import 'auth_error.dart';
import 'safe_emit.dart';
import 'email_code_state.dart';

/// The 6-digit email code (the gate after sign-up, and after a log-in with an
/// unverified email). Screen-scoped: created by the code route.
class EmailCodeCubit({
  required final VerifyEmail _verifyEmail,
  required final ResendEmailCode _resendEmailCode,
  required final ChangeEmailAddress _changeEmailAddress,
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
    switch (await _verifyEmail(state.code)) {
      case Ok(:final value):
        final session = value.session;
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
    switch (await _resendEmailCode(const NoParams())) {
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

  /// Fixes a mistyped email while the account is still unverified.
  Future<Failure?> changeEmail(String newEmail) async {
    switch (await _changeEmailAddress(newEmail.trim())) {
      case Ok(:final value):
        emit(
          state.copyWith(
            email: newEmail.trim(),
            code: '',
            status: EmailCodeStatus.entering,
            error: null,
            nextSendAt: value.nextSendAt,
          ),
        );
        return null;
      case Err(:final failure):
        return failure;
    }
  }
}
