// ignore: use_primary_constructors (no constructor by design: static-only constants)
abstract final class Routes {
  static const splash = '/splash';
  static const welcome = '/welcome';

  static const password = '/welcome/password';
  static const join = '/welcome/join';
  static const forgot = '/welcome/forgot';
  static const forgotSent = '/welcome/forgot/sent';
  static const forgotHelp = '/welcome/forgot/help';

  static const code = '/welcome/code';
  static const phone = '/welcome/phone';
  static const verified = '/welcome/done';

  /// Opened from the link in the reset email: `/reset?token=...`.
  static const reset = '/reset';

  // Tab roots (StatefulShellRoute).
  static const home = '/home';
  static const shop = '/shop';
  static const plan = '/plan';
  static const orders = '/orders';
  static const savings = '/savings';

  // Opened from the Home avatar, not a tab.
  static const account = '/account';
  static const appearance = '/account/appearance';
}
