// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RefreshRequestModelToJson(
  RefreshRequestModel instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

RefreshResponseModel _$RefreshResponseModelFromJson(
  Map<String, dynamic> json,
) => RefreshResponseModel(
  tokens: json['tokens'] == null
      ? null
      : SessionModel.fromJson(json['tokens'] as Map<String, dynamic>),
);
