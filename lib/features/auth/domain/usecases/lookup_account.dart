import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/account_lookup.dart';
import '../repositories/auth_repository.dart';

/// Does this email already have an account?
class const LookupAccount(final AuthRepository _repository)
    implements UseCase<AccountLookup, String> {
  @override
  Future<Result<AccountLookup>> call(String params) =>
      _repository.lookup(params);
}
