import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_outcome.dart';
import '../entities/new_account.dart';
import '../repositories/auth_repository.dart';

class const SignUp(final AuthRepository _repository)
    implements UseCase<AuthOutcome, NewAccount> {
  @override
  Future<Result<AuthOutcome>> call(NewAccount params) =>
      _repository.signUp(params);
}
