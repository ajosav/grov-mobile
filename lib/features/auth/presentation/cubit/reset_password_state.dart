import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../session/domain/entities/session.dart';
import '../../domain/entities/password_problem.dart';
import 'auth_error.dart';

part 'reset_password_state.freezed.dart';

enum ResetLinkStatus() {
  checking,
  ready,

  /// Expired, used, or unreadable: the same screen, a new link is the fix.
  dead,
}

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    @Default(ResetLinkStatus.checking) ResetLinkStatus link,
    @Default(false) bool busy,
    @Default(<PasswordProblem>{}) Set<PasswordProblem> problems,
    @Default(false) bool serverChecked,
    AuthError? error,
    Session? signedInSession,
  }) = _ResetPasswordState;
}
