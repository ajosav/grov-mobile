import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_outcome.dart';
import '../repositories/auth_repository.dart';

/// Sets a new password from the link; signs in on this device.
class const ResetPassword(final AuthRepository _repository)
    implements UseCase<AuthOutcome, ({String token, String password})> {
  @override
  Future<Result<AuthOutcome>> call(({String token, String password}) params) =>
      _repository.resetPassword(params.token, params.password);
}
