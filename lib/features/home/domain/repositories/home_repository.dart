import '../../../../core/error/result.dart';
import '../entities/home_summary.dart';

// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class HomeRepository {
  Stream<Result<HomeSummary>> watchHome();
}
