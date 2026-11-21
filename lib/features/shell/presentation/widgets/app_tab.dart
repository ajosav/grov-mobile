import 'package:material_ui/material_ui.dart';

import '../../../../l10n/app_localizations.dart';

/// Tab order must match the `StatefulShellBranch` order in `app_router.dart`.
enum AppTab(this.icon, this.selectedIcon) {
  home(Icons.home_outlined, Icons.home),
  shop(Icons.storefront_outlined, Icons.storefront),
  plan(Icons.event_note_outlined, Icons.event_note),
  orders(Icons.local_shipping_outlined, Icons.local_shipping),
  savings(Icons.savings_outlined, Icons.savings);

  final IconData icon;
  final IconData selectedIcon;

  String label(AppLocalizations l10n) => switch (this) {
    home => l10n.navHome,
    shop => l10n.navShop,
    plan => l10n.navPlan,
    orders => l10n.navOrders,
    savings => l10n.navSavings,
  };
}
