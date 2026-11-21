// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPairModel _$TokenPairModelFromJson(Map<String, dynamic> json) =>
    TokenPairModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
