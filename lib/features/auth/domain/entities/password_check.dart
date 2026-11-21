import 'package:freezed_annotation/freezed_annotation.dart';

import 'password_problem.dart';

part 'password_check.freezed.dart';

@freezed
abstract class PasswordCheck with _$PasswordCheck {
  const factory PasswordCheck({
    required bool ok,
    @Default(<PasswordProblem>{}) Set<PasswordProblem> problems,
  }) = _PasswordCheck;
}
