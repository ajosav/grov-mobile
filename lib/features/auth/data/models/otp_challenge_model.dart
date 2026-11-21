import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/otp_challenge.dart';

part 'otp_challenge_model.g.dart';

/// API `OtpChallengeSummary`.
@JsonSerializable(createToJson: false)
class const OtpChallengeModel({
  required final DateTime expiresAt,
  required final DateTime nextSendAt,
}) {
  factory OtpChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$OtpChallengeModelFromJson(json);

  OtpChallenge toEntity() =>
      OtpChallenge(expiresAt: expiresAt, nextSendAt: nextSendAt);
}
