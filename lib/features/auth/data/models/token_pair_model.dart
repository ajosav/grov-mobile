import 'package:json_annotation/json_annotation.dart';

part 'token_pair_model.g.dart';

/// API `TokenPair`.
@JsonSerializable(createToJson: false)
class const TokenPairModel({
  required final String accessToken,
  required final String refreshToken,
  required final DateTime expiresAt,
}) {
  factory TokenPairModel.fromJson(Map<String, dynamic> json) =>
      _$TokenPairModelFromJson(json);
}
