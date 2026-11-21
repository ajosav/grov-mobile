import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/layout/content_frame.dart';
import '../../../../core/layout/app_screen.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/app_banner.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../sync/presentation/widgets/sync_status_line.dart';
import '../../../sync/presentation/cubit/sync_status_cubit.dart';
import '../../../sync/presentation/cubit/sync_status_state.dart';

class const HomeView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(l10n.navHome),
          actions: [
            IconButton(
              tooltip: l10n.accountOpenLabel,
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () => context.push(Routes.account),
            ),
          ],
        ),
        body: ContentFrame(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpace.s2),
                  child: SyncStatusLine(),
                ),
              ),
              SliverToBoxAdapter(
                // Rebuild only when the online flag flips.
                child: BlocSelector<SyncStatusCubit, SyncStatusState, bool>(
                  selector: (s) => s.online,
                  builder: (context, online) => online
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: AppSpace.s3),
                          child: AppBanner(
                            title: l10n.offlineBannerTitle,
                            body: l10n.offlineBannerBody,
                          ),
                        ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.event_note_outlined,
                  title: l10n.homeNoPlanTitle,
                  body: l10n.homeNoPlanBody(BrandConfig.name),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
