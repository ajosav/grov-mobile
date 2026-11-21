import '../../../../core/error/result.dart';
import '../../domain/entities/home_meal_idea.dart';
import '../../domain/entities/home_summary.dart';
import '../../domain/entities/meal_time.dart';
import '../../domain/repositories/home_repository.dart';

/// Stands in until the API has a home summary (DECISIONS M-043). Figures are
/// the ones drawn in the Figma Home frame and `design/system/sample-data.json`.
class const FixtureHomeRepository() implements HomeRepository {
  @override
  Stream<Result<HomeSummary>> watchHome() => Stream.value(
    const Result.ok(
      HomeSummary(
        householdName: 'Ngozi',
        budgetUsedPercent: 72,
        mealsCompleted: 8,
        mealsPlanned: 14,
        mealIdea: HomeMealIdea(
          id: 'beans-and-plantain',
          title: 'Beans and plantain',
          mealTime: MealTime.lunch,
          cooked: true,
          // TEMP: delete with the asset when the API serves photos.
          photoAsset: 'assets/images/meal_beans_plantain.jpg',
        ),
        stockToBuyCount: 3,
        stockToBuyKobo: 720000,
      ),
    ),
  );
}
