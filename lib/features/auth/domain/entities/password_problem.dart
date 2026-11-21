/// Why a password is not accepted yet. Matches the checklist on the join and
/// reset screens.
enum PasswordProblem() {
  tooShort,
  noSymbol,
  common,
  emailLocalPart,
}
