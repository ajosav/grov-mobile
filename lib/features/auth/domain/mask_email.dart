/// `ngozi.adeyemi@gmail.com` -> `ng***@gmail.com`. Shown in notes so the
/// address is recognisable without printing it in full.
String maskEmail(String email) {
  final at = email.indexOf('@');
  if (at <= 0) {
    return email;
  }
  final local = email.substring(0, at);
  final shown = local.length <= 2
      ? local.substring(0, 1)
      : local.substring(0, 2);
  return '$shown***${email.substring(at)}';
}
