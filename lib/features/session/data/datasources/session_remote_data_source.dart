import '../models/logout_request_model.dart';
import '../models/refresh_models.dart';
import '../models/session_model.dart';
import 'auth_api.dart';
import 'session_api.dart';

class const SessionRemoteDataSource(
  final AuthApi _api,

  /// Built on first use: its Dio needs the session tokens, and the session
  /// needs this data source, so building it eagerly would be a cycle.
  final SessionApi Function() _sessionApi,
) {
  /// `null` when the server revoked the session.
  Future<SessionModel?> refresh(String refreshToken) async {
    final response = await _api.refresh(
      RefreshRequestModel(refreshToken: refreshToken),
    );
    return response.data.tokens;
  }

  /// Ends this session on the server. The bearer token comes from the
  /// authenticated client, so call it before the tokens are cleared.
  Future<void> logout() async {
    await _sessionApi().logout(const LogoutRequestModel(forgetDevice: false));
  }
}
