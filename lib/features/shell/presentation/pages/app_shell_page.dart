import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layout/app_window.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/app_tab.dart';
import '../widgets/floating_nav_bar.dart';

/// Tab chrome that adapts to the window (D40):
/// compact = bottom bar; medium and expanded = navigation rail.
/// Task flows (sign-on, checkout, account) sit outside this shell, so the nav
/// is hidden there.
class const AppShellView({
  required final StatefulNavigationShell navigationShell,
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  void _select(int i) => navigationShell.goBranch(
    i,
    initialLocation: i == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final window = AppWindow.of(context);
    final index = navigationShell.currentIndex;

    if (window.isCompact) {
      return Scaffold(
        // The floating bar sits over the page; the page reads the bar's
        // height from MediaQuery padding and scrolls clear of it.
        extendBody: true,
        body: child,
        bottomNavigationBar: FloatingNavBar(
          selectedIndex: index,
          onSelected: _select,
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              selectedIndex: index,
              onDestinationSelected: _select,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final t in AppTab.values)
                  NavigationRailDestination(
                    icon: Icon(t.icon),
                    selectedIcon: Icon(t.selectedIcon),
                    label: Text(t.label(l10n)),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
