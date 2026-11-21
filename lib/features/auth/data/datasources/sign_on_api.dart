import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_response.dart';
import '../models/auth_response_model.dart';
import '../models/client_config_model.dart';
import '../models/forgot_accepted_model.dart';
import '../models/lookup_response_model.dart';
import '../models/password_check_model.dart';
import '../models/reset_link_check_model.dart';

part 'sign_on_api.g.dart';

/// Retrofit contract for the endpoints a signed-out person calls. Built on the
/// interceptor-free Dio: there is no token to attach and no refresh to try.
@RestApi()
abstract class SignOnApi {
  factory SignOnApi(Dio dio, {String? baseUrl}) = _SignOnApi;

  @GET('/v1/config')
  Future<ApiResponse<ClientConfigModel>> getConfig();

  @POST('/v1/auth/lookup')
  Future<ApiResponse<LookupResponseModel>> lookup(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/password/check')
  Future<ApiResponse<PasswordCheckModel>> checkPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/signup')
  Future<ApiResponse<AuthResponseModel>> signUp(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/login')
  Future<ApiResponse<AuthResponseModel>> logIn(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/password/forgot')
  Future<ApiResponse<ForgotAcceptedModel>> forgotPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/password/reset/check')
  Future<ApiResponse<ResetLinkCheckModel>> checkResetLink(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/password/reset')
  Future<ApiResponse<AuthResponseModel>> resetPassword(
    @Body() Map<String, dynamic> body,
  );
}
