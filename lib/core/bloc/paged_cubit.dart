import 'package:flutter_bloc/flutter_bloc.dart';

import '../error/result.dart';
import '../pagination/page_result.dart';
import '../pagination/paged_state.dart';

abstract class PagedCubit<T>() extends Cubit<PagedState<T>> {
  this : super(PagedState<T>());

  /// Fetch one page. [cursor] is null for the first page. Never throws.
  Future<Result<PageResult<T>>> fetchPage(String? cursor);

  int _generation = 0;
  bool _busy = false;

  Future<void> refresh() async {
    final generation = ++_generation;
    _busy = true;
    if (state.items.isEmpty) {
      emit(PagedState<T>().copyWith(status: PagedStatus.loading));
    }
    final result = await fetchPage(null);
    if (isClosed || generation != _generation) {
      return;
    }
    _busy = false;
    emit(
      result.when(
        ok: (page) => state.withFirstPage(page),
        err: (_) => state.items.isEmpty
            ? state.copyWith(status: PagedStatus.failure)
            : state.copyWith(status: PagedStatus.ready),
      ),
    );
  }

  Future<void> loadMore() async {
    final retrying = state.status == PagedStatus.loadMoreFailed;
    if (_busy || !(state.canLoadMore || retrying)) {
      return;
    }
    final cursor = state.nextCursor;
    if (cursor == null) {
      return;
    }
    final generation = _generation;
    _busy = true;
    emit(state.copyWith(status: PagedStatus.loadingMore));
    final result = await fetchPage(cursor);
    if (isClosed || generation != _generation) {
      return;
    }
    _busy = false;
    emit(
      result.when(
        ok: (page) => state.withNextPage(page),
        err: (_) => state.copyWith(status: PagedStatus.loadMoreFailed),
      ),
    );
  }
}
