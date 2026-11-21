// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  gate:
      $enumDecodeNullable(
        _$AuthGateEnumMap,
        json['gate'],
        unknownValue: AuthGate.none,
      ) ??
      AuthGate.none,
  email: json['email'] as String?,
);

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'gate': _$AuthGateEnumMap[instance.gate]!,
      'email': instance.email,
    };

const _$AuthGateEnumMap = {
  AuthGate.none: 'none',
  AuthGate.verifyEmail: 'verifyEmail',
  AuthGate.addPhone: 'addPhone',
  AuthGate.acceptTerms: 'acceptTerms',
  AuthGate.mfa: 'mfa',
  AuthGate.mfaEnrol: 'mfaEnrol',
};
