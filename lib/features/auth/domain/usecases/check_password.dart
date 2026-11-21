import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/password_check.dart';
import '../repositories/auth_repository.dart';

/// The server's live password checklist (common passwords, email part).
class const CheckPassword(final AuthRepository _repository)
    implements UseCase<PasswordCheck, ({String password, String? email})> {
  @override
  Future<Result<PasswordCheck>> call(
    ({String password, String? email}) params,
  ) => _repository.checkPassword(params.password, email: params.email);
}
