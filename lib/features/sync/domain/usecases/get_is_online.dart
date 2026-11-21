import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/sync_repository.dart';

class const GetIsOnline(final SyncRepository _repository)
    implements UseCase<bool, NoParams> {
  @override
  Future<Result<bool>> call(NoParams params) => _repository.isOnline();
}
