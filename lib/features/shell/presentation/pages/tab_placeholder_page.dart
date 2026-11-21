import 'package:material_ui/material_ui.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/layout/app_screen.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/app_tab.dart';

class const TabPlaceholderView({required final AppTab tab, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(tab.label(l10n))),
        body: EmptyState(
          icon: tab.icon,
          title: l10n.comingSoonTitle,
          body: l10n.comingSoonBody(BrandConfig.name),
        ),
      ),
    );
  }
}
