import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class const GetTermsVersion(final AuthRepository _repository)
    implements UseCase<String, NoParams> {
  @override
  Future<Result<String>> call(NoParams params) => _repository.getTermsVersion();
}
