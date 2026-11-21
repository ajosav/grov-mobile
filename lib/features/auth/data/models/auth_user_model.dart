import 'package:json_annotation/json_annotation.dart';

part 'auth_user_model.g.dart';

/// API `AuthUser`, the part the app uses.
@JsonSerializable(createToJson: false)
class const AuthUserModel({
  required final String firstName,
  required final String email,
  required final bool emailVerified,
}) {
  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
