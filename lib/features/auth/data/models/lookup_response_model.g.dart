// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookupResponseModel _$LookupResponseModelFromJson(Map<String, dynamic> json) =>
    LookupResponseModel(
      state: json['state'] as String,
      hasPassword: json['hasPassword'] as bool,
      providers:
          (json['providers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
