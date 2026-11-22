import 'package:freezed_annotation/freezed_annotation.dart';

import 'meal_time.dart';

part 'home_meal_idea.freezed.dart';

/// A meal the plan suggests for today.
@freezed
abstract class HomeMealIdea with _$HomeMealIdea {
  const factory HomeMealIdea({
    required String id,
    required String title,
    required MealTime mealTime,
    required bool cooked,

    /// Picture served by the backend. The app bundles no meal images.
    String? photoUrl,

    /// TEMP test data only: a bundled picture used when [photoUrl] is null.
    /// Delete this field and its asset once the API supplies photos.
    String? photoAsset,
  }) = _HomeMealIdea;
}
