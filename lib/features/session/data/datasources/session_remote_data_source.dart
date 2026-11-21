import '../models/refresh_models.dart';
import '../models/session_model.dart';
import 'auth_api.dart';

class const SessionRemoteDataSource(final AuthApi _api) {
  /// `null` when the server revoked the session.
  Future<SessionModel?> refresh(String refreshToken) async {
    final response = await _api.refresh(
      RefreshRequestModel(refreshToken: refreshToken),
    );
    return response.data.tokens;
  }
}
