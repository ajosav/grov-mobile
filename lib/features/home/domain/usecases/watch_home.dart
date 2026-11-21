import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/home_summary.dart';
import '../repositories/home_repository.dart';

class const WatchHome(final HomeRepository _repository)
    implements StreamUseCase<HomeSummary, NoParams> {
  @override
  Stream<Result<HomeSummary>> call(NoParams params) => _repository.watchHome();
}
