import '../error/failure.dart';

/// Maps an API error response to a [Failure]. Branch on the stable `code`,
/// never on `message` (developer text).
Failure mapApiFailure(int? status, Object? body) {
  final map = body is Map<String, dynamic> ? body : const <String, dynamic>{};
  final message = map['message'] as String?;
  final code = map['code'] as String?;
  switch (status) {
    case 400:
      return BadRequestFailure(message, code);
    case 401:
      return UnauthorizedFailure(message, code);
    case 403:
      return ForbiddenFailure(message, code);
    case 404:
      return const NotFoundFailure();
    case 409:
      return ConflictFailure(message, code);
    case 410:
      return GoneFailure(message, code);
    case 422:
      final raw = map['errors'];
      final fields = <String, List<String>>{};
      if (raw is Map) {
        raw.forEach((k, v) {
          fields['$k'] = v is List ? v.map((e) => '$e').toList() : ['$v'];
        });
      }
      return ValidationFailure(fields, message, code, _params(map));
    case 429:
      return RateLimitedFailure(message, code, _params(map));
  }
  if (status != null && status >= 500) {
    return ServerFailure(message);
  }
  return UnknownFailure(message);
}

Map<String, Object?> _params(Map<String, dynamic> map) {
  final raw = map['params'];
  return raw is Map<String, dynamic> ? raw : const <String, Object?>{};
}
