import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class const ApiResponse<T>({
  required final bool status,
  required final int statusCode,
  required final String message,
  required final T data,
  final PageMeta? meta,
}) {
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

/// `meta` on paginated lists: `{ path, perPage, nextCursor, prevCursor }`.
@JsonSerializable(createToJson: false)
class const PageMeta({
  final int? perPage,
  final String? nextCursor,
  final String? prevCursor,
}) {
  factory PageMeta.fromJson(Map<String, dynamic> json) =>
      _$PageMetaFromJson(json);
}
