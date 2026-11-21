import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/password_check.dart';
import '../../domain/entities/password_problem.dart';

part 'password_check_model.g.dart';

/// API `PasswordCheck`: `problems` are `TOO_SHORT`, `NO_SYMBOL`, `COMMON`,
/// `EMAIL_LOCAL_PART`.
@JsonSerializable(createToJson: false)
class const PasswordCheckModel({
  required final bool ok,
  final List<String> problems = const [],
}) {
  factory PasswordCheckModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordCheckModelFromJson(json);

  PasswordCheck toEntity() => PasswordCheck(
    ok: ok,
    problems: {
      for (final p in problems)
        switch (p) {
          'TOO_SHORT' => PasswordProblem.tooShort,
          'NO_SYMBOL' => PasswordProblem.noSymbol,
          'COMMON' => PasswordProblem.common,
          'EMAIL_LOCAL_PART' => PasswordProblem.emailLocalPart,
          _ => null,
        },
    }.nonNulls.toSet(),
  );
}
