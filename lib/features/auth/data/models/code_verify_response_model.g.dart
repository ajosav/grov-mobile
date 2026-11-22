// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_verify_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeVerifyResponseModel _$CodeVerifyResponseModelFromJson(
  Map<String, dynamic> json,
) => CodeVerifyResponseModel(
  state: json['state'] as String,
  auth: json['auth'] == null
      ? null
      : AuthResponseModel.fromJson(json['auth'] as Map<String, dynamic>),
  registration: json['registration'] == null
      ? null
      : RegistrationModel.fromJson(
          json['registration'] as Map<String, dynamic>,
        ),
);
