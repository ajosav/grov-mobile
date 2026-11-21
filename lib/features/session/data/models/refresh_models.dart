import 'package:json_annotation/json_annotation.dart';

import 'session_model.dart';

part 'refresh_models.g.dart';

/// POST /v1/auth/refresh body.
@JsonSerializable(createFactory: false)
class const RefreshRequestModel({required final String refreshToken}) {
  Map<String, dynamic> toJson() => _$RefreshRequestModelToJson(this);
}

/// POST /v1/auth/refresh `data`. `tokens` is null when the session was revoked.
@JsonSerializable(createToJson: false)
class const RefreshResponseModel({final SessionModel? tokens}) {
  factory RefreshResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseModelFromJson(json);
}
