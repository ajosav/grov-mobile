import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../session/domain/entities/session.dart';
import 'auth_error.dart';

part 'email_code_state.freezed.dart';

enum EmailCodeStatus() {
  entering,
  verifying,

  /// Code accepted: boxes turn green, then the page hands over the session.
  accepted,

  /// Five wrong tries: boxes are disabled until a new code is sent.
  locked,
}

@freezed
abstract class EmailCodeState with _$EmailCodeState {
  const factory EmailCodeState({
    required String email,
    @Default('') String code,
    @Default(EmailCodeStatus.entering) EmailCodeStatus status,
    AuthError? error,
    DateTime? nextSendAt,
    @Default(false) bool resending,

    /// Set when the code was accepted; the page passes it to the session.
    Session? verifiedSession,
  }) = _EmailCodeState;
}
