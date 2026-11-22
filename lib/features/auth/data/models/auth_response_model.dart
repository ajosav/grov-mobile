import 'package:json_annotation/json_annotation.dart';

import '../../../session/domain/entities/auth_gate.dart';
import '../../../session/domain/entities/session.dart';
import '../../domain/entities/auth_outcome.dart';
import 'auth_user_model.dart';
import 'otp_challenge_model.dart';
import 'token_pair_model.dart';

part 'auth_response_model.g.dart';

/// API `AuthResponse`. `tokens` is null when the server wants a step this app
/// cannot do (two-step sign-in), `challenge` when an email code was sent.
@JsonSerializable(createToJson: false)
class const AuthResponseModel({
  required final String nextStep,
  required final AuthUserModel user,
  final TokenPairModel? tokens,
  final OtpChallengeModel? challenge,
}) {
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  AuthOutcome toEntity() {
    final pair = tokens;
    final gate = _gateOf(nextStep);
    // Only the steps this app can finish get a session. For the rest (two-step
    // sign-in, stale terms) the app must not open, so no session is made.
    final supported = gate == AuthGate.none || gate == AuthGate.addPhone;
    return AuthOutcome(
      session: pair == null || !supported
          ? null
          : Session(
              accessToken: pair.accessToken,
              refreshToken: pair.refreshToken,
              expiresAt: pair.expiresAt,
              gate: gate,
              email: user.email,
            ),
      challenge: challenge?.toEntity(),
      firstName: user.firstName,
    );
  }

  static AuthGate _gateOf(String step) => switch (step) {
    'DONE' => AuthGate.none,
    'VERIFY_EMAIL' => AuthGate.verifyEmail,
    'ADD_PHONE' => AuthGate.addPhone,
    'ACCEPT_TERMS' => AuthGate.acceptTerms,
    'MFA' => AuthGate.mfa,
    'MFA_ENROL' => AuthGate.mfaEnrol,
    // A step this build does not know is treated as the strictest unknown
    // gate rather than as "done".
    _ => AuthGate.mfa,
  };
}
