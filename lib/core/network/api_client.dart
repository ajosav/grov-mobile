import 'package:dio/dio.dart';

import '../error/failure.dart';
import '../error/result.dart';
import 'interceptors.dart';

/// Compile-time API host: `--dart-define=API_BASE_URL=https://api.example.com`.
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:3000',
);

/// One Dio instance for the app. Repositories are its only callers.
Dio buildDio(TokenProvider tokens, {String baseUrl = apiBaseUrl}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: const {'Accept': 'application/json', 'Accept-Encoding': 'gzip'},
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(tokens),
    RefreshInterceptor(tokens, dio),
    FailureInterceptor(),
    ?debugLogInterceptor(),
  ]);
  return dio;
}

/// Runs [call] and maps any thrown error to a [Failure].
Future<Result<T>> guardApi<T>(Future<T> Function() call) async {
  try {
    return Result.ok(await call());
  } on DioException catch (e) {
    return Result.err(
      e.error is Failure ? e.error! as Failure : const UnknownFailure(),
    );
  } on FormatException {
    return const Result.err(ServerFailure());
  } on Object {
    return const Result.err(UnknownFailure());
  }
}

/// Interceptor-free Dio for calls that must not recurse into auth (token
/// refresh) and for unauthenticated calls.
Dio buildBareDio({String baseUrl = apiBaseUrl}) => Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: const {'Accept': 'application/json', 'Accept-Encoding': 'gzip'},
  ),
)..interceptors.add(FailureInterceptor());
