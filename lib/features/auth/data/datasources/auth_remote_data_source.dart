import '../../domain/entities/new_profile.dart';
import '../models/auth_response_model.dart';
import '../models/client_config_model.dart';
import '../models/code_verify_response_model.dart';
import '../models/otp_challenge_model.dart';
import 'device_identity_data_source.dart';
import 'gated_auth_api.dart';
import 'sign_on_api.dart';

/// Builds the request bodies and unwraps `ApiResponse.data`.
class const AuthRemoteDataSource(
  final SignOnApi _signOn,
  final GatedAuthApi _gated,
  final DeviceIdentityDataSource _device,
) {
  Future<ClientConfigModel> getConfig() async =>
      (await _signOn.getConfig()).data;

  Future<OtpChallengeModel> requestCode(String email) async =>
      (await _signOn.requestCode({'email': email})).data;

  Future<CodeVerifyResponseModel> verifyCode(String email, String code) async =>
      (await _signOn.verifyCode({
        'email': email,
        'code': code,
        'device': await _device.read(),
      })).data;

  Future<AuthResponseModel> completeProfile(NewProfile profile) async =>
      (await _signOn.completeProfile({
        'ticket': profile.ticket,
        'firstName': profile.firstName,
        'lastName': profile.lastName,
        'phone': profile.phone,
        'termsVersion': profile.termsVersion,
        'device': await _device.read(),
      })).data;

  Future<AuthResponseModel> completePhone(String phone) async =>
      (await _gated.completePhone({'phone': phone})).data;
}
