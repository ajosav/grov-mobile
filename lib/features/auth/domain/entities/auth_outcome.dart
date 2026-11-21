import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../session/domain/entities/session.dart';
import 'otp_challenge.dart';

part 'auth_outcome.freezed.dart';

/// What the server answered to a sign-up, log-in, code or reset call.
///
/// [session] is null when the server wants a step this app does not do yet
/// (for example two-step sign-in), so no tokens came back.
@freezed
abstract class AuthOutcome with _$AuthOutcome {
  const factory AuthOutcome({
    Session? session,
    OtpChallenge? challenge,
    String? firstName,
  }) = _AuthOutcome;
}
