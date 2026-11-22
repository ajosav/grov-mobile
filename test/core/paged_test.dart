import 'package:app_mobile/core/bloc/paged_cubit.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/core/pagination/page_result.dart';
import 'package:app_mobile/core/pagination/paged_state.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/core/widgets/app_button.dart';
import 'package:app_mobile/core/widgets/paged_list_view.dart';
import 'package:app_mobile/core/widgets/skeleton.dart';
import 'package:app_mobile/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// 25 items in pages of 10. Can be told to fail once.
class _Numbers() extends PagedCubit<int> {
  this : super();
  final cursors = <String?>[];
  bool failNext = false;

  @override
  Future<Result<PageResult<int>>> fetchPage(String? cursor) async {
    cursors.add(cursor);

    if (failNext) {
      failNext = false;
      return const Result.err(CacheFailure());
    }
    final from = cursor == null ? 0 : int.parse(cursor);
    final to = (from + 10).clamp(0, 25);
    return Result.ok(
      PageResult(
        items: [for (var i = from; i < to; i++) i],
        nextCursor: to >= 25 ? null : '$to',
      ),
    );
  }
}

void main() {
  group('PagedCubit', () {
    test('first load, then pages until the end', () async {
      final c = _Numbers();
      addTearDown(c.close);
      await c.refresh();
      expect(c.state.items.length, 10);
      expect(c.state.hasMore, isTrue);
      await c.loadMore();
      await c.loadMore();
      expect(c.state.items.length, 25);
      expect(c.state.hasMore, isFalse);
      await c.loadMore(); // at the end: no request
      expect(c.cursors, [null, '10', '20']);
    });

    test('a failed next page keeps items and retries with loadMore', () async {
      final c = _Numbers();
      addTearDown(c.close);
      await c.refresh();
      c.failNext = true;
      await c.loadMore();
      expect(c.state.status, PagedStatus.loadMoreFailed);
      expect(c.state.items.length, 10);
      await c.loadMore();
      expect(c.state.status, PagedStatus.ready);
      expect(c.state.items.length, 20);
    });

    test('a failed first page is a failure; refresh recovers', () async {
      final c = _Numbers()..failNext = true;
      addTearDown(c.close);
      await c.refresh();
      expect(c.state.status, PagedStatus.failure);
      await c.refresh();
      expect(c.state.status, PagedStatus.ready);
    });

    test('loadMore is ignored before the first page and while busy', () async {
      final c = _Numbers();
      addTearDown(c.close);
      await c.loadMore();
      expect(c.cursors, isEmpty);
      await c.refresh();
      await Future.wait([c.loadMore(), c.loadMore(), c.loadMore()]);
      expect(c.cursors, [null, '10']);
    });
  });

  group('PagedListView', () {
    Widget host(_Numbers c, PagedState<int> s) => MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: PagedListView<int>(
          state: s,
          itemBuilder: (_, i) => SizedBox(height: 80, child: Text('item $i')),
          skeletonBuilder: (_) => const SkeletonBox(height: 80),
          onLoadMore: c.loadMore,
          onRetry: c.refresh,
        ),
      ),
    );

    testWidgets('ghost rows on first load', (tester) async {
      final c = _Numbers();
      addTearDown(c.close);
      await tester.pumpWidget(
        host(c, const PagedState<int>(status: PagedStatus.loading)),
      );
      expect(find.byType(SkeletonBox), findsWidgets);
      expect(find.textContaining('item'), findsNothing);
    });

    testWidgets('scrolling to the bottom loads the next pages', (tester) async {
      final c = _Numbers();
      addTearDown(c.close);
      await c.refresh();
      await tester.pumpWidget(_Live(c, (s) => host(c, s)));
      expect(c.state.items.length, greaterThanOrEqualTo(10));
      await tester.drag(find.byType(ListView), const Offset(0, -3000));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0, -3000));
      await tester.pumpAndSettle();
      expect(c.state.items.length, 25);
      expect(c.state.hasMore, isFalse);
    });

    testWidgets('a failed next page shows a retry row', (tester) async {
      final c = _Numbers();
      addTearDown(c.close);
      await c.refresh();
      c.failNext = true;
      await tester.pumpWidget(_Live(c, (s) => host(c, s)));
      await tester.drag(find.byType(ListView), const Offset(0, -3000));
      await tester.pumpAndSettle();
      expect(find.text('Could not load more.'), findsOneWidget);
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();
      expect(find.text('Could not load more.'), findsNothing);
    });
  });

  testWidgets('a loading button says what is happening', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppButton(
            label: 'Log in',
            loading: true,
            loadingLabel: 'Signing in…',
            onPressed: () {},
          ),
        ),
      ),
    );
    expect(find.text('Signing in…'), findsOneWidget);
    expect(find.text('Log in'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class const _Live(
  final _Numbers _cubit,
  final Widget Function(PagedState<int>) _make,
) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder<PagedState<int>>(
    initialData: _cubit.state,
    stream: _cubit.stream,
    builder: (_, snap) => _make(snap.data!),
  );
}
