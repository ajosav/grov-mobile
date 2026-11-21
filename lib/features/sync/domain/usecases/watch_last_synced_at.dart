import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/sync_repository.dart';

class const WatchLastSyncedAt(final SyncRepository _repository)
    implements StreamUseCase<DateTime?, NoParams> {
  @override
  Stream<Result<DateTime?>> call(NoParams params) =>
      _repository.watchLastSyncedAt();
}
