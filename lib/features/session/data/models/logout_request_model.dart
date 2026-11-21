import 'package:json_annotation/json_annotation.dart';

part 'logout_request_model.g.dart';

/// POST /v1/auth/logout body. `forgetDevice` also drops this device's trust.
@JsonSerializable(createFactory: false)
class const LogoutRequestModel({required final bool forgetDevice}) {
  Map<String, dynamic> toJson() => _$LogoutRequestModelToJson(this);
}
