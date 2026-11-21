import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_challenge.freezed.dart';

/// A sent email code: when it stops working and when another may be asked for.
@freezed
abstract class OtpChallenge with _$OtpChallenge {
  const factory OtpChallenge({
    required DateTime expiresAt,
    required DateTime nextSendAt,
  }) = _OtpChallenge;
}
