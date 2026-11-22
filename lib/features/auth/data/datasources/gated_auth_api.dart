import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/api_response.dart';
import '../models/auth_response_model.dart';

part 'gated_auth_api.g.dart';

/// Retrofit contract for the call that clears a gate (phone). It needs the
/// gated session's bearer token, so this is built on the app Dio.
@RestApi()
abstract class GatedAuthApi {
  factory GatedAuthApi(Dio dio, {String? baseUrl}) = _GatedAuthApi;

  @POST('/v1/auth/phone/complete')
  Future<ApiResponse<AuthResponseModel>> completePhone(
    @Body() Map<String, dynamic> body,
  );
}
