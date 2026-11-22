import 'dart:convert';

import 'package:dio/dio.dart';

const _redacted = {
  'password',
  'newpassword',
  'currentpassword',
  'accesstoken',
  'refreshtoken',
  'token',
  'idtoken',
  'otp',
  'authorization',
  'email',
  'phone',
  'phonenumber',
  'firstname',
  'lastname',
  'name',
  'card',
  'pan',
  'cvv',
};

const _maxBody = 1200;
const _startKey = 'http_log_started_at';

/// Debug-only, one block per call: request line, then status, time and the
/// server's error `code`, `message`, `errors` and `traceId`, so a failure can be
/// matched to the backend log. Request bodies show field names only; response
/// bodies are redacted by [redactForLog].
class HttpLogInterceptor(final void Function(String line) _log)
    extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startKey] = DateTime.now().microsecondsSinceEpoch;
    _log(formatRequest(options));
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log(
      formatResponse(
        response.requestOptions,
        response.statusCode,
        response.data,
        _elapsed(response.requestOptions),
      ),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log(
      formatResponse(
        err.requestOptions,
        err.response?.statusCode,
        err.response?.data,
        _elapsed(err.requestOptions),
        failure: err.error,
        type: err.type,
      ),
    );
    handler.next(err);
  }
}

Duration _elapsed(RequestOptions o) {
  final start = o.extra[_startKey];
  if (start is! int) return Duration.zero;
  return Duration(microseconds: DateTime.now().microsecondsSinceEpoch - start);
}

String _line(RequestOptions o) => '${o.method} ${o.uri.path}';

String formatRequest(RequestOptions o) {
  final data = o.data;
  final fields = data is Map ? ' body keys: ${data.keys.join(', ')}' : '';
  final query = o.uri.hasQuery ? '?${o.uri.query}' : '';
  return '--> ${_line(o)}$query$fields';
}

String formatResponse(
  RequestOptions o,
  int? status,
  Object? body,
  Duration took, {
  Object? failure,
  DioExceptionType? type,
}) {
  final ms = '${took.inMilliseconds}ms';
  final head = status == null
      ? '<-- ${_line(o)} no response (${type?.name ?? 'unknown'}) $ms'
      : '<-- $status ${_line(o)} $ms';
  final out = StringBuffer(head);
  if (failure != null) out.write('\n    mapped to: ${failure.runtimeType}');
  if (body is Map) {
    final b = redactForLog(body)! as Map;
    for (final k in const ['code', 'message', 'traceId']) {
      if (b[k] != null) out.write('\n    $k: ${b[k]}');
    }
  }
  if (body != null) {
    var text = jsonEncode(redactForLog(body));
    if (text.length > _maxBody) text = '${text.substring(0, _maxBody)}…';
    out.write('\n    body: $text');
  }
  return out.toString();
}

/// A copy of [value] with every sensitive key's value replaced.
Object? redactForLog(Object? value) {
  if (value is Map) {
    return {
      for (final e in value.entries)
        '${e.key}': _redacted.contains('${e.key}'.toLowerCase())
            ? '***'
            : redactForLog(e.value),
    };
  }
  if (value is List) return value.map(redactForLog).toList();
  return value;
}
