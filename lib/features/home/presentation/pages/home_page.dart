import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/layout/app_screen.dart';
import '../../../../core/layout/content_frame.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_banner.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../sync/presentation/cubit/sync_status_cubit.dart';
import '../../../sync/presentation/cubit/sync_status_state.dart';
import '../../../sync/presentation/widgets/sync_status_line.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_header.dart';
import '../widgets/home_skeleton.dart';
import '../widgets/meal_idea_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/section_header.dart';
import '../widgets/stock_list_row.dart';
import '../widgets/week_progress_card.dart';

class const HomeView({super.key}) extends StatelessWidget {
  void _comingSoon(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.comingSoonBody(BrandConfig.name))),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: ContentFrame(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.s5),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppSpace.s2),
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
                            padding: const EdgeInsets.only(top: AppSpace.s3),
                            child: AppBanner(
                              title: l10n.offlineBannerTitle,
                              body: l10n.offlineBannerBody,
                            ),
                          ),
                  ),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) => switch (state) {
                    HomeLoading() => const SliverToBoxAdapter(
                      child: HomeSkeleton(),
                    ),
                    HomeFailure() => SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(
                        title: l10n.homeLoadFailedTitle,
                        body: l10n.homeLoadFailedBody,
                        icon: Icons.cloud_off_outlined,
                        action: TextButton(
                          onPressed: () => context.read<HomeCubit>().load(),
                          child: Text(l10n.homeRetry),
                        ),
                      ),
                    ),
                    HomeData() => _content(context, state),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, HomeData state) {
    final l10n = AppLocalizations.of(context);
    final s = state.summary;
    final meal = s.mealIdea;
    // The floating nav reports its height through the bottom padding.
    final bottom = MediaQuery.paddingOf(context).bottom + AppSpace.s6;
    void openPlan() => context.go(Routes.plan);

    return SliverList.list(
      children: [
        const SizedBox(height: AppSpace.s2),
        HomeHeader(
          name: s.householdName,
          period: state.period,
          onNotifications: () => _comingSoon(context),
          onAccount: () => context.push(Routes.account),
        ),
        const SizedBox(height: AppSpace.s4),
        WeekProgressCard(
          budgetUsedPercent: s.budgetUsedPercent,
          mealsCompleted: s.mealsCompleted,
          mealsPlanned: s.mealsPlanned,
        ),
        const SizedBox(height: AppSpace.s6),
        SectionHeader(
          l10n.homeMealIdeasTitle,
          linkLabel: l10n.homeViewAll,
          onLink: openPlan,
        ),
        const SizedBox(height: AppSpace.s3),
        if (meal != null) ...[
          MealIdeaCard(meal: meal, onTap: openPlan),
          const SizedBox(height: AppSpace.s3),
        ],
        StockListRow(
          itemsToBuy: s.stockToBuyCount,
          kobo: s.stockToBuyKobo,
          onTap: openPlan,
        ),
        const SizedBox(height: AppSpace.s6),
        SectionHeader(l10n.homeQuickActionsTitle),
        const SizedBox(height: AppSpace.s3),
        QuickActions(
          onViewPlan: openPlan,
          onBulkCooked: () => _comingSoon(context),
          onSharingSlot: () => _comingSoon(context),
          onAdjustBudget: () => _comingSoon(context),
        ),
        SizedBox(height: bottom),
      ],
    );
  }
}
