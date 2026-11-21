import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_outcome.dart';
import '../repositories/auth_repository.dart';

/// Password log-in. An unverified email comes back gated, with a code sent.
class const LogIn(final AuthRepository _repository)
    implements UseCase<AuthOutcome, ({String email, String password})> {
  @override
  Future<Result<AuthOutcome>> call(({String email, String password}) params) =>
      _repository.logIn(params.email, params.password);
}
