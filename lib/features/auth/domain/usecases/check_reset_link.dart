import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Is this reset link still good? Checked before the form is shown.
class const CheckResetLink(final AuthRepository _repository)
    implements UseCase<bool, String> {
  @override
  Future<Result<bool>> call(String params) =>
      _repository.checkResetLink(params);
}
