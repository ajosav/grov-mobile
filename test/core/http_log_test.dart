import 'package:app_mobile/core/network/http_log_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final req = RequestOptions(
    path: '/v1/auth/signup',
    method: 'POST',
    baseUrl: 'http://localhost:3000',
    data: {'email': 'a@b.c', 'password': 'hunter2'},
  );

  test('a request shows field names, never values', () {
    final line = formatRequest(req);
    expect(line, contains('POST /v1/auth/signup'));
    expect(line, contains('email, password'));
    expect(line, isNot(contains('hunter2')));
    expect(line, isNot(contains('a@b.c')));
  });

  test('a 409 shows status, code, message and trace id', () {
    final out = formatResponse(
      req,
      409,
      {
        'code': 'AUTH_TERMS_VERSION_STALE',
        'message': 'The terms changed',
        'traceId': 't-1',
        'params': {'currentVersion': 'draft'},
      },
      const Duration(milliseconds: 42),
      failure: Exception('x'),
    );
    expect(out, contains('<-- 409 POST /v1/auth/signup 42ms'));
    expect(out, contains('code: AUTH_TERMS_VERSION_STALE'));
    expect(out, contains('traceId: t-1'));
    expect(out, contains('currentVersion'));
  });

  test('tokens and personal details are redacted in responses', () {
    final out = formatResponse(req, 200, {
      'data': {'accessToken': 'SECRET', 'email': 'a@b.c', 'ok': 1},
    }, Duration.zero);
    expect(out, isNot(contains('SECRET')));
    expect(out, isNot(contains('a@b.c')));
    expect(out, contains('"ok":1'));
  });

  test('no response is stated plainly', () {
    final out = formatResponse(
      req,
      null,
      null,
      Duration.zero,
      type: DioExceptionType.connectionError,
    );
    expect(out, contains('no response (connectionError)'));
  });
}
