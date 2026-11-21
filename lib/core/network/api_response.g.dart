// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiResponse<T>(
  status: json['status'] as bool,
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  data: fromJsonT(json['data']),
  meta: json['meta'] == null
      ? null
      : PageMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

PageMeta _$PageMetaFromJson(Map<String, dynamic> json) => PageMeta(
  perPage: (json['perPage'] as num?)?.toInt(),
  nextCursor: json['nextCursor'] as String?,
  prevCursor: json['prevCursor'] as String?,
);
