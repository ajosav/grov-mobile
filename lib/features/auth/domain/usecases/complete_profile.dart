import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_outcome.dart';
import '../entities/new_profile.dart';
import '../repositories/auth_repository.dart';

/// Creates the account after a correct code for a new address.
class const CompleteProfile(final AuthRepository _repository)
    implements UseCase<AuthOutcome, NewProfile> {
  @override
  Future<Result<AuthOutcome>> call(NewProfile params) =>
      _repository.completeProfile(params);
}
