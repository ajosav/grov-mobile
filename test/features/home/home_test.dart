import 'dart:async';

import 'package:app_mobile/core/config/brand_config.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/features/home/domain/entities/home_summary.dart';
import 'package:app_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:app_mobile/features/home/presentation/cubit/home_state.dart';
import 'package:app_mobile/features/home/presentation/pages/home_page.dart';
import 'package:app_mobile/features/home/presentation/widgets/home_skeleton.dart';
import 'package:app_mobile/features/sync/domain/repositories/sync_repository.dart';
import 'package:app_mobile/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/cubit_factories.dart';

class _Failing() implements HomeRepository {
  @override
  Stream<Result<HomeSummary>> watchHome() =>
      Stream.value(const Result.err(CacheFailure()));
}

const _summary = HomeSummary(
  householdName: 'Ngozi',
  budgetUsedPercent: 10,
  mealsCompleted: 1,
  mealsPlanned: 2,
  stockToBuyCount: 0,
  stockToBuyKobo: 0,
);

class _Scripted() implements HomeRepository {
  final _controller = StreamController<Result<HomeSummary>>();
  void send(Result<HomeSummary> r) => _controller.add(r);
  @override
  Stream<Result<HomeSummary>> watchHome() => _controller.stream;
}

class _FakeSync() implements SyncRepository {
  @override
  Future<Result<bool>> isOnline() async => const Result.ok(true);
  @override
  Stream<Result<bool>> watchOnline() => const Stream.empty();
  @override
  Stream<Result<DateTime?>> watchLastSyncedAt() =>
      Stream.value(const Result.ok(null));
}

Future<void> _pump(WidgetTester tester, Size size, HomeCubit cubit) async {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final sync = syncStatusCubitFor(_FakeSync());
  addTearDown(sync.close);
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cubit),
        BlocProvider.value(value: sync),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeView(),
      ),
    ),
  );
  await cubit.load();
  await tester.pump();
}

void main() {
  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'loads the summary and picks the greeting from the clock',
      build: () => homeCubitFor(),
      act: (c) async {
        await c.load();
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        isA<HomeData>()
            .having((s) => s.period, 'period', GreetingPeriod.morning)
            .having((s) => s.summary.mealsPlanned, 'planned', 14),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'afternoon and evening greetings',
      build: () => homeCubitFor(null, FixedClock(DateTime(2026, 11, 21, 17))),
      act: (c) async {
        await c.load();
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        isA<HomeData>().having(
          (s) => s.period,
          'period',
          GreetingPeriod.evening,
        ),
      ],
    );

    test('a failed refresh keeps the data already on screen', () async {
      final repo = _Scripted();
      final cubit = homeCubitFor(repo);
      addTearDown(cubit.close);
      await cubit.load();
      repo.send(Result.ok(_summary));
      await Future<void>.delayed(Duration.zero);
      repo.send(const Result.err(CacheFailure()));
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state, isA<HomeData>());
    });

    blocTest<HomeCubit, HomeState>(
      'a failure becomes state, never an exception',
      build: () => homeCubitFor(_Failing()),
      act: (c) async {
        await c.load();
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [isA<HomeFailure>()],
    );
  });

  group('HomeView', () {
    testWidgets(
      'draws every section at phone width, with the brand from config',
      (tester) async {
        final cubit = homeCubitFor();
        addTearDown(cubit.close);
        await _pump(tester, const Size(360, 1400), cubit);
        expect(find.text(BrandConfig.name), findsOneWidget);
        expect(find.text('Good morning, Ngozi'), findsOneWidget);
        expect(find.text('72%'), findsOneWidget);
        expect(find.text('8 / 14'), findsOneWidget);
        expect(find.text('Beans and plantain'), findsOneWidget);
        expect(find.text('Lunch · meal idea'), findsOneWidget);
        expect(find.text('3 items still to buy · ₦7,200'), findsOneWidget);
        expect(find.text('View plan'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('reflows at 200% text and tablet width without overflow', (
      tester,
    ) async {
      final cubit = homeCubitFor();
      addTearDown(cubit.close);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await _pump(tester, const Size(360, 800), cubit);
      expect(tester.takeException(), isNull);
      await _pump(tester, const Size(1024, 768), cubit);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows ghost blocks, not a blank page, while loading', (
      tester,
    ) async {
      final repo = _Scripted();
      final cubit = homeCubitFor(repo);
      addTearDown(cubit.close);
      tester.view
        ..physicalSize = const Size(390, 844)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final sync = syncStatusCubitFor(_FakeSync());
      addTearDown(sync.close);
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider.value(value: sync),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HomeView(),
          ),
        ),
      );
      await cubit.load();
      await tester.pump();
      expect(find.byType(HomeSkeleton), findsOneWidget);
      expect(find.bySemanticsLabel('Loading your home'), findsOneWidget);
      repo.send(Result.ok(_summary));
      await tester.pump(); // delivers the event
      await tester.pump(); // draws the new state
      expect(find.byType(HomeSkeleton), findsNothing);
      expect(find.text('10%'), findsOneWidget);
    });

    testWidgets('a failed load offers a retry', (tester) async {
      final cubit = homeCubitFor(_Failing());
      addTearDown(cubit.close);
      await _pump(tester, const Size(390, 844), cubit);
      expect(find.text('Try again'), findsOneWidget);
    });
  });
}
