import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/code_verification.dart';
import '../repositories/auth_repository.dart';

typedef VerifySignInCodeParams = ({String email, String code});

/// Checks the code: signs an existing account in, or asks for a profile.
class const VerifySignInCode(final AuthRepository _repository)
    implements UseCase<CodeVerification, VerifySignInCodeParams> {
  @override
  Future<Result<CodeVerification>> call(VerifySignInCodeParams params) =>
      _repository.verifyCode(params.email, params.code);
}
