import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_response.dart';
import '../models/auth_response_model.dart';
import '../models/client_config_model.dart';
import '../models/code_verify_response_model.dart';
import '../models/otp_challenge_model.dart';

part 'sign_on_api.g.dart';

/// Retrofit contract for the endpoints a signed-out person calls. Built on the
/// interceptor-free Dio: there is no token to attach and no refresh to try.
@RestApi()
abstract class SignOnApi {
  factory SignOnApi(Dio dio, {String? baseUrl}) = _SignOnApi;

  @GET('/v1/config')
  Future<ApiResponse<ClientConfigModel>> getConfig();

  @POST('/v1/auth/code/request')
  Future<ApiResponse<OtpChallengeModel>> requestCode(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/code/verify')
  Future<ApiResponse<CodeVerifyResponseModel>> verifyCode(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/code/complete')
  Future<ApiResponse<AuthResponseModel>> completeProfile(
    @Body() Map<String, dynamic> body,
  );
}
