import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/session.dart';

part 'session_state.freezed.dart';

@freezed
sealed class SessionState with _$SessionState {
  const factory SessionState.unknown() = SessionUnknown;
  const factory SessionState.signedOut() = SessionSignedOut;
  const factory SessionState.signedIn(Session session) = SessionSignedIn;
}
