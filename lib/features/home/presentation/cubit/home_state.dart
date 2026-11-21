import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/home_summary.dart';

part 'home_state.freezed.dart';

enum GreetingPeriod() {
  morning,
  afternoon,
  evening,
}

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.data({
    required HomeSummary summary,
    required GreetingPeriod period,
  }) = HomeData;
  const factory HomeState.failure() = HomeFailure;
}
