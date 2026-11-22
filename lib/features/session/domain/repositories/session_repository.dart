import '../../../../core/error/result.dart';
import '../entities/session.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class SessionRepository {
  /// The stored session, or `Ok(null)` when signed out.
  Future<Result<Session?>> restore();

  Future<Result<void>> save(Session session);

  /// Tells the server to end this session. Needs the stored tokens, so call it
  /// before [clear]. A failure here must not stop a local sign-out.
  Future<Result<void>> revoke();

  /// Signs out locally: clears the stored tokens.
  Future<Result<void>> clear();

  /// Rotates the token pair. `Ok(null)` means the server revoked the session
  /// and the user must sign in again.
  Future<Result<Session?>> refresh(Session current);
}
