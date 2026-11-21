import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_response.dart';
import '../models/logout_request_model.dart';

part 'session_api.g.dart';

/// Authenticated session calls. Built on the app's main Dio so the bearer
/// token is attached (unlike [AuthApi], whose Dio has no interceptors).
@RestApi()
abstract class SessionApi {
  factory SessionApi(Dio dio, {String? baseUrl}) = _SessionApi;

  @POST('/v1/auth/logout')
  Future<ApiResponse<dynamic>> logout(@Body() LogoutRequestModel body);
}
