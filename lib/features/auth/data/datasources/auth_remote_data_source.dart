import '../models/auth_response_model.dart';
import '../models/client_config_model.dart';
import '../models/forgot_accepted_model.dart';
import '../models/lookup_response_model.dart';
import '../models/otp_challenge_model.dart';
import '../models/password_check_model.dart';
import '../models/reset_link_check_model.dart';
import 'device_identity_data_source.dart';
import 'gated_auth_api.dart';
import 'sign_on_api.dart';

/// Builds the request bodies and unwraps `ApiResponse.data`.
class const AuthRemoteDataSource(
  final SignOnApi _signOn,
  final GatedAuthApi _gated,
  final DeviceIdentityDataSource _device,
) {
  Future<ClientConfigModel> getConfig() async => (await _signOn.getConfig()).data;

  Future<LookupResponseModel> lookup(String email) async =>
      (await _signOn.lookup({'email': email})).data;

  Future<PasswordCheckModel> checkPassword(
    String password,
    String? email,
  ) async =>
      (await _signOn.checkPassword({'password': password, 'email': ?email}))
          .data;

  Future<AuthResponseModel> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String termsVersion,
  }) async => (await _signOn.signUp({
    'email': email,
    'firstName': firstName,
    // Optional in the API: leave it out rather than send an empty string.
    if (lastName.isNotEmpty) 'lastName': lastName,
    'phone': phone,
    'password': password,
    'termsVersion': termsVersion,
    'device': await _device.read(),
  })).data;

  Future<AuthResponseModel> logIn(String email, String password) async =>
      (await _signOn.logIn({
        'method': 'PASSWORD',
        'email': email,
        'password': password,
        'device': await _device.read(),
      })).data;

  Future<ForgotAcceptedModel> forgotPassword(String email) async =>
      (await _signOn.forgotPassword({'email': email})).data;

  Future<ResetLinkCheckModel> checkResetLink(String token) async =>
      (await _signOn.checkResetLink({'token': token})).data;

  Future<AuthResponseModel> resetPassword(
    String token,
    String password,
  ) async => (await _signOn.resetPassword({
    'token': token,
    'password': password,
    'device': await _device.read(),
  })).data;

  Future<AuthResponseModel> verifyEmail(String code) async =>
      (await _gated.verifyEmail({'code': code})).data;

  Future<OtpChallengeModel> resendEmailCode() async =>
      (await _gated.resendEmailCode(const {})).data;

  Future<OtpChallengeModel> changeEmailAddress(String newEmail) async =>
      (await _gated.changeEmailAddress({'newEmail': newEmail})).data;

  Future<AuthResponseModel> completePhone(String phone) async =>
      (await _gated.completePhone({'phone': phone})).data;
}
