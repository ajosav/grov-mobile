import 'page_result.dart';

enum PagedStatus() {
  initial,

  loading,

  ready,

  loadingMore,

  loadMoreFailed,

  failure,
}

class const PagedState<T>({
  final PagedStatus status = PagedStatus.initial,
  final List<T> items = const [],
  final String? nextCursor,
}) {
  bool get hasMore => nextCursor != null;
  bool get isEmpty => status == PagedStatus.ready && items.isEmpty;

  bool get canLoadMore => status == PagedStatus.ready && hasMore;

  PagedState<T> copyWith({
    PagedStatus? status,
    List<T>? items,
    String? Function()? nextCursor,
  }) => PagedState<T>(
    status: status ?? this.status,
    items: items ?? this.items,
    nextCursor: nextCursor != null ? nextCursor() : this.nextCursor,
  );

  PagedState<T> withFirstPage(PageResult<T> page) => PagedState<T>(
    status: PagedStatus.ready,
    items: List.unmodifiable(page.items),
    nextCursor: page.nextCursor,
  );

  PagedState<T> withNextPage(PageResult<T> page) => PagedState<T>(
    status: PagedStatus.ready,
    items: List.unmodifiable([...items, ...page.items]),
    nextCursor: page.nextCursor,
  );
}
