import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/failure.dart';
import 'failure_mapper.dart';
import 'http_log_interceptor.dart';

// ignore: use_primary_constructors (no constructor by design: interface)
abstract interface class TokenProvider {
  String? get accessToken;
  Future<String?> refresh();
}

class AuthInterceptor(final TokenProvider _tokens) extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokens.accessToken;
    if (token != null && options.extra['skipAuth'] != true) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class RefreshInterceptor(final TokenProvider _tokens, final Dio _dio)
    extends Interceptor {
  Future<String?>? _inFlight;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;
    final eligible =
        err.response?.statusCode == 401 &&
        req.extra['skipAuth'] != true &&
        req.extra['retried'] != true;
    if (!eligible) return handler.next(err);

    final fresh = await (_inFlight ??= _tokens.refresh().whenComplete(
      () => _inFlight = null,
    ));
    if (fresh == null) return handler.next(err);

    try {
      req.extra['retried'] = true;
      req.headers['Authorization'] = 'Bearer $fresh';
      handler.resolve(await _dio.fetch<dynamic>(req));
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}

class FailureInterceptor() extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const TimeoutFailure(),
      DioExceptionType.connectionError => const OfflineFailure(),
      DioExceptionType.badResponse => mapApiFailure(
        err.response?.statusCode,
        err.response?.data,
      ),
      _ => const UnknownFailure(),
    };
    handler.next(err.copyWith(error: failure));
  }
}

Interceptor? debugLogInterceptor() =>
    kDebugMode ? HttpLogInterceptor((line) => debugPrint(line)) : null;
