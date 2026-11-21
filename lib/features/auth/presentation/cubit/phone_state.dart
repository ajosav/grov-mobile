import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../session/domain/entities/session.dart';
import 'auth_error.dart';

part 'phone_state.freezed.dart';

@freezed
abstract class PhoneState with _$PhoneState {
  const factory PhoneState({
    @Default(false) bool busy,
    AuthError? error,
    Session? signedInSession,
  }) = _PhoneState;
}
