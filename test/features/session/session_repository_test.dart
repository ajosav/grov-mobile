import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/core/network/interceptors.dart';
import 'package:app_mobile/features/session/data/datasources/auth_api.dart';
import 'package:app_mobile/features/session/data/datasources/session_local_data_source.dart';
import 'package:app_mobile/features/session/data/datasources/session_remote_data_source.dart';
import 'package:app_mobile/features/session/data/repositories/session_repository_impl.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorage() extends Mock implements FlutterSecureStorage {}

/// Plays canned responses through the real Dio interceptors and the real
/// Retrofit `AuthApi`, so the wire contract and failure mapping are covered.
class _StubAdapter(final int status, final Map<String, dynamic> body)
    implements HttpClientAdapter {
  RequestOptions? last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    last = options;
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dio(_StubAdapter adapter) => Dio(BaseOptions(baseUrl: 'http://test'))
  ..httpClientAdapter = adapter
  ..interceptors.add(FailureInterceptor());

final _current = Session(
  accessToken: 'old',
  refreshToken: 'old-refresh-token-xxxxxxxx',
  expiresAt: DateTime.utc(2030),
);

SessionRepositoryImpl _repo(_StubAdapter adapter, _MockStorage storage) =>
    SessionRepositoryImpl(
      local: SessionLocalDataSource(storage),
      remote: SessionRemoteDataSource(AuthApi(_dio(adapter))),
    );

void main() {
  late _MockStorage storage;
  setUp(() {
    storage = _MockStorage();
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
  });

  test('refresh posts the refresh token, parses the envelope and persists the new pair', () async {
    final adapter = _StubAdapter(200, {
      'status': true,
      'statusCode': 200,
      'message': 'Success',
      'data': {
        'tokens': {
          'accessToken': 'new',
          'refreshToken': 'new-r',
          'expiresAt': '2030-01-01T00:00:00.000Z',
        },
      },
    });
    final result = await _repo(adapter, storage).refresh(_current);

    expect(result.valueOrNull?.accessToken, 'new');
    expect(adapter.last?.path, '/v1/auth/refresh');
    expect(adapter.last?.data, {'refreshToken': 'old-refresh-token-xxxxxxxx'});
    verify(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).called(1);
  });

  test('null tokens (revoked) is Ok(null) and nothing is persisted', () async {
    final adapter = _StubAdapter(200, {
      'status': true,
      'statusCode': 200,
      'message': 'Success',
      'data': {'tokens': null},
    });
    final result = await _repo(adapter, storage).refresh(_current);
    expect(result, isA<Ok<Session?>>());
    expect(result.valueOrNull, isNull);
    verifyNever(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    );
  });

  test('401 from refresh means the session is gone: Ok(null)', () async {
    final adapter = _StubAdapter(401, {
      'status': false,
      'statusCode': 401,
      'message': 'x',
      'code': 'TOKEN_INVALID',
    });
    final result = await _repo(adapter, storage).refresh(_current);
    expect(result, isA<Ok<Session?>>());
    expect(result.valueOrNull, isNull);
  });

  test('500 maps to ServerFailure and does not sign the user out', () async {
    final adapter = _StubAdapter(500, {
      'status': false,
      'statusCode': 500,
      'message': 'boom',
      'code': 'INTERNAL',
    });
    final result = await _repo(adapter, storage).refresh(_current);
    expect(result.failureOrNull, isA<ServerFailure>());
  });

  test('a throwing secure store becomes CacheFailure, never an exception', () async {
    when(() => storage.read(key: any(named: 'key')))
        .thenThrow(Exception('keystore'));
    final result = await _repo(_StubAdapter(200, const {}), storage).restore();
    // Local source swallows corrupt reads as signed-out; save failures surface:
    expect(result, isA<Ok<Session?>>());
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenThrow(Exception('full'));
    final saved = await _repo(
      _StubAdapter(200, const {}),
      storage,
    ).save(_current);
    expect(saved.failureOrNull, isA<CacheFailure>());
  });
}
