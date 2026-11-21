// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      nextStep: json['nextStep'] as String,
      user: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
      tokens: json['tokens'] == null
          ? null
          : TokenPairModel.fromJson(json['tokens'] as Map<String, dynamic>),
      challenge: json['challenge'] == null
          ? null
          : OtpChallengeModel.fromJson(
              json['challenge'] as Map<String, dynamic>,
            ),
    );
