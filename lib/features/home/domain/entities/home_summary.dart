import 'package:freezed_annotation/freezed_annotation.dart';

import 'home_meal_idea.dart';

part 'home_summary.freezed.dart';

@freezed
abstract class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    required String householdName,
    required int budgetUsedPercent,
    required int mealsCompleted,
    required int mealsPlanned,
    HomeMealIdea? mealIdea,
    required int stockToBuyCount,

    required int stockToBuyKobo,
  }) = _HomeSummary;
}
