import 'entities/password_problem.dart';

/// The two checks that need no server: length and a symbol. "Common" and
/// "email local part" come from the server's list.
Set<PasswordProblem> localPasswordProblems(String password) => {
  if (password.length < 8) PasswordProblem.tooShort,
  if (!RegExp(r'[^A-Za-z0-9]').hasMatch(password)) PasswordProblem.noSymbol,
};
