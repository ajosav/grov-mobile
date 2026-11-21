import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_gate.dart';

part 'session.freezed.dart';

/// A signed-in session. Tokens live in memory and in secure storage only,
/// never in Drift. While [gate] is not [AuthGate.none] the tokens only open
/// the screens that clear the gate (verify email, add phone).
@freezed
abstract class Session with _$Session {
  const factory Session({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    @Default(AuthGate.none) AuthGate gate,

    /// The account email, kept so a gate screen can say where the code went.
    String? email,
  }) = _Session;
}
