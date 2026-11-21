import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layout/content_frame.dart';
import '../../../../core/layout/app_screen.dart';
import '../../../../core/router/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../session/presentation/cubit/session_cubit.dart';

class const AccountView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(l10n.accountTitle)),
        body: ContentFrame(
          maxWidth: ContentFrame.formWidth,
          child: ListView(
            children: [
              ListTile(
                minTileHeight: 56,
                title: Text(l10n.appearanceTitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(Routes.appearance),
              ),
              ListTile(
                minTileHeight: 56,
                title: Text(l10n.signOut),
                onTap: () => context.read<SessionCubit>().signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
