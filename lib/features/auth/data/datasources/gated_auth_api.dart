import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_response.dart';
import '../models/auth_response_model.dart';
import '../models/otp_challenge_model.dart';

part 'gated_auth_api.g.dart';

/// Retrofit contract for the calls that clear a gate (email code, phone). They
/// need the gated session's bearer token, so this is built on the app Dio.
@RestApi()
abstract class GatedAuthApi {
  factory GatedAuthApi(Dio dio, {String? baseUrl}) = _GatedAuthApi;

  @POST('/v1/auth/email/verify')
  Future<ApiResponse<AuthResponseModel>> verifyEmail(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/email/resend')
  Future<ApiResponse<OtpChallengeModel>> resendEmailCode(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/email/change-address')
  Future<ApiResponse<OtpChallengeModel>> changeEmailAddress(
    @Body() Map<String, dynamic> body,
  );

  @POST('/v1/auth/phone/complete')
  Future<ApiResponse<AuthResponseModel>> completePhone(
    @Body() Map<String, dynamic> body,
  );
}
