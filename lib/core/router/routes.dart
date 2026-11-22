// ignore: use_primary_constructors (no constructor by design: static-only constants)
abstract final class Routes {
  static const splash = '/splash';
  static const welcome = '/welcome';

  static const code = '/welcome/code';
  static const profile = '/welcome/profile';
  static const phone = '/welcome/phone';
  static const verified = '/welcome/done';

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
