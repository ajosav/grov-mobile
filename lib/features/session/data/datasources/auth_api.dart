import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_response.dart';
import '../models/refresh_models.dart';

part 'auth_api.g.dart';

/// Retrofit contract for the auth endpoints (from the backend OpenAPI contract).
/// Only data sources use it; repositories and below never see Dio.
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  /// Uses the interceptor-free Dio, so `skipAuth` is documentation here: a
  /// refresh must never trigger another refresh.
  @POST('/v1/auth/refresh')
  @Extra({'skipAuth': true})
  Future<ApiResponse<RefreshResponseModel>> refresh(
    @Body() RefreshRequestModel body,
  );
}
