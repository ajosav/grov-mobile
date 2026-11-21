import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/sync_repository.dart';

class const WatchOnline(final SyncRepository _repository)
    implements StreamUseCase<bool, NoParams> {
  @override
  Stream<Result<bool>> call(NoParams params) => _repository.watchOnline();
}
