import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/interceptors.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/session.dart';
import '../../domain/usecases/refresh_session.dart';
import '../../domain/usecases/restore_session.dart';
import '../../domain/usecases/save_session.dart';
import '../../domain/usecases/sign_out.dart';
import 'session_state.dart';

class SessionCubit({
  required final RestoreSession _restoreSession,
  required final SaveSession _saveSession,
  required final SignOut _signOut,
  required final RefreshSession _refreshSession,
}) extends Cubit<SessionState> implements TokenProvider {
  this : super(const SessionState.unknown());

  @override
  String? get accessToken => switch (state) {
    SessionSignedIn(:final session) => session.accessToken,
    _ => null,
  };

  Future<void> restore() async {
    final result = await _restoreSession(const NoParams());
    // An unreadable store is treated as signed out: Welcome is always safe.
    final session = result.valueOrNull;
    emit(
      session == null
          ? const SessionState.signedOut()
          : SessionState.signedIn(session),
    );
  }

  Future<void> signedIn(Session session) async {
    await _saveSession(session);
    emit(SessionState.signedIn(session));
  }

  /// [revoke] is false when the server already ended the session.
  Future<void> signOut({bool revoke = true}) async {
    await _signOut(revoke);
    emit(const SessionState.signedOut());
  }

  @override
  Future<String?> refresh() async {
    final current = switch (state) {
      SessionSignedIn(:final session) => session,
      _ => null,
    };
    if (current == null) {
      return null;
    }

    final result = await _refreshSession(current);
    if (result.failureOrNull != null) {
      return null;
    }
    final next = result.valueOrNull;
    if (next == null) {
      await signOut(revoke: false);
      return null;
    }
    emit(SessionState.signedIn(next));
    return next.accessToken;
  }
}
