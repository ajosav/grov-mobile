import 'package:material_ui/material_ui.dart';

import '../../l10n/app_localizations.dart';
import '../pagination/paged_state.dart';
import '../theme/app_tokens.dart' hide formatNaira;
import 'empty_state.dart';
import 'skeleton.dart';

class const PagedListView<T>({
  required final PagedState<T> state,
  required final Widget Function(BuildContext context, T item) itemBuilder,

  /// One ghost row, shaped like a real row. Used for the first load (repeated
  /// [skeletonCount] times) and as the "loading more" row.
  required final WidgetBuilder skeletonBuilder,
  required final VoidCallback onLoadMore,
  required final VoidCallback onRetry,

  /// Shown when the first page is empty. Defaults to nothing.
  final Widget? empty,
  final Future<void> Function()? onRefresh,
  final int skeletonCount = 6,

  /// How far ahead of the bottom the next page is requested.
  final double prefetchExtent = 480,
  final EdgeInsetsGeometry padding = EdgeInsets.zero,
  final double separator = AppSpace.s3,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (state.status) {
      case PagedStatus.initial:
      case PagedStatus.loading:
        return _scroll(
          context,
          itemCount: skeletonCount,
          builder: (context, _) => skeletonBuilder(context),
          wrap: true,
        );
      case PagedStatus.failure:
        return Center(
          child: EmptyState(
            title: l10n.pagedLoadFailedTitle,
            body: l10n.pagedLoadFailedBody,
            icon: Icons.cloud_off_outlined,
            action: TextButton(
              onPressed: onRetry,
              child: Text(l10n.commonRetry),
            ),
          ),
        );
      case PagedStatus.ready:
      case PagedStatus.loadingMore:
      case PagedStatus.loadMoreFailed:
        if (state.isEmpty) {
          return empty ?? const SizedBox.shrink();
        }
        final items = state.items;
        final hasFooter = state.status != PagedStatus.ready || state.hasMore;
        return _scroll(
          context,
          itemCount: items.length + (hasFooter ? 1 : 0),
          builder: (context, i) {
            if (i < items.length) {
              return itemBuilder(context, items[i]);
            }
            return switch (state.status) {
              PagedStatus.loadMoreFailed => _RetryRow(
                message: l10n.pagedLoadMoreFailed,
                action: l10n.commonRetry,
                onRetry: onLoadMore,
              ),
              PagedStatus.loadingMore => Skeleton(
                child: skeletonBuilder(context),
              ),
              _ => _LoadMoreTrigger(
                key: ValueKey(items.length),
                onVisible: onLoadMore,
                child: const SizedBox(height: 1),
              ),
            };
          },
        );
    }
  }

  Widget _scroll(
    BuildContext context, {
    required int itemCount,
    required IndexedWidgetBuilder builder,
    bool wrap = false,
  }) {
    final list = ListView.separated(
      padding: padding,
      scrollCacheExtent: ScrollCacheExtent.pixels(prefetchExtent),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, _) => SizedBox(height: separator),
      itemBuilder: builder,
    );
    final body = wrap ? Skeleton(child: IgnorePointer(child: list)) : list;
    return onRefresh == null || wrap
        ? body
        : RefreshIndicator(onRefresh: onRefresh!, child: body);
  }
}

class const _LoadMoreTrigger({
  required final VoidCallback onVisible,
  required final Widget child,
  super.key,
}) extends StatefulWidget {
  @override
  State<_LoadMoreTrigger> createState() => _LoadMoreTriggerState();
}

class _LoadMoreTriggerState() extends State<_LoadMoreTrigger> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onVisible();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class const _RetryRow({
  required final String message,
  required final String action,
  required final VoidCallback onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpace.s3),
    child: Column(
      children: [
        Text(
          message,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: context.tokens.inkMuted),
        ),
        TextButton(onPressed: onRetry, child: Text(action)),
      ],
    ),
  );
}
