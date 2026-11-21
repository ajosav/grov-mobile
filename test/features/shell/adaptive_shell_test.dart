import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter_test/flutter_test.dart';

import 'package:app_mobile/core/di/injection.dart';
import 'package:app_mobile/features/auth/presentation/pages/welcome_page.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

import 'package:app_mobile/core/layout/app_window.dart';
import 'package:app_mobile/core/layout/two_pane.dart';
import 'package:app_mobile/core/router/app_router.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';
import 'package:app_mobile/features/session/domain/repositories/session_repository.dart';
import 'package:app_mobile/features/session/presentation/cubit/session_cubit.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/sync/domain/repositories/sync_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_mobile/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

class _FakeSessions(this.stored) implements SessionRepository {
  Session? stored;
  @override
  Future<Result<Session?>> restore() async => Result.ok(stored);
  @override
  Future<Result<void>> save(Session s) async {
    stored = s;
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> clear() async {
    stored = null;
    return const Result.ok(null);
  }

  @override
  Future<Result<Session?>> refresh(Session current) async => Result.ok(current);
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

Future<void> _pump(
  WidgetTester tester,
  Size size,
  SessionCubit session, {
  List<DisplayFeature> features = const [],
}) async {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1
    ..displayFeatures = features;
  addTearDown(tester.view.reset);
  final router = buildRouter(session);
  addTearDown(router.dispose);
  final sync = syncStatusCubitFor(_FakeSync());
  addTearDown(sync.close);
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: session),
        BlocProvider.value(value: sync),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  // The router builds the sign-on cubit from DI; tests give it a fake repo.
  setUp(() {
    getIt.registerFactory(() => signOnCubitFor(FakeAuthRepository()));
  });
  tearDown(getIt.reset);

  final signedIn = Session(
    accessToken: 'a',
    refreshToken: 'r',
    expiresAt: DateTime.utc(2030),
  );

  group('router redirects (D37: Welcome is the only door)', () {
    testWidgets('signed out lands on Welcome', (tester) async {
      final session = sessionCubitFor(_FakeSessions(null));
      addTearDown(session.close);
      await _pump(tester, const Size(390, 844), session);
      await session.restore();
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('signed in lands on Home with tabs', (tester) async {
      final session = sessionCubitFor(_FakeSessions(signedIn));
      addTearDown(session.close);
      await _pump(tester, const Size(390, 844), session);
      await session.restore();
      await tester.pumpAndSettle();
      expect(find.text('No plan yet'), findsOneWidget);
    });
  });

  group('every device (D40)', () {
    Future<SessionCubit> signedInSession() async {
      final s = sessionCubitFor(_FakeSessions(signedIn));
      await s.restore();
      return s;
    }

    testWidgets('360pt phone: bottom bar, no rail', (tester) async {
      final s = await signedInSession();
      addTearDown(s.close);
      await _pump(tester, const Size(360, 640), s);
      await tester.pumpAndSettle();
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('700pt fold inner screen: rail', (tester) async {
      final s = await signedInSession();
      addTearDown(s.close);
      await _pump(tester, const Size(700, 800), s);
      await tester.pumpAndSettle();
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('1024pt iPad: rail, content stays capped', (tester) async {
      final s = await signedInSession();
      addTearDown(s.close);
      await _pump(tester, const Size(1024, 768), s);
      await tester.pumpAndSettle();
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'fold and unfold: the window resizes live and state survives (iPhone Duo, Android folds)',
      (tester) async {
        final s = await signedInSession();
        addTearDown(s.close);
        await _pump(tester, const Size(390, 844), s);
        await tester.pumpAndSettle();

        // Compact (folded): bottom bar. Go to the second tab.
        expect(find.byType(NavigationBar), findsOneWidget);
        await tester.tap(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text('Shop'),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Coming soon'), findsOneWidget);

        // Unfold: the same app, wider window. Nav switches to a rail, the tab
        // stays selected, nothing restarts.
        tester.view.physicalSize = const Size(720, 800);
        await tester.pumpAndSettle();
        expect(find.byType(NavigationRail), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);
        expect(
          tester
              .widget<NavigationRail>(find.byType(NavigationRail))
              .selectedIndex,
          1,
        );
        expect(find.text('Coming soon'), findsOneWidget);

        // Fold again.
        tester.view.physicalSize = const Size(390, 844);
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<NavigationBar>(find.byType(NavigationBar))
              .selectedIndex,
          1,
        );
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('200% text scale does not overflow on a 360pt phone', (
      tester,
    ) async {
      final s = await signedInSession();
      addTearDown(s.close);
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await _pump(tester, const Size(360, 640), s);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });

  group('AppWindow', () {
    test('classes by width', () {
      expect(WindowClass.fromWidth(359), WindowClass.compact);
      expect(WindowClass.fromWidth(600), WindowClass.medium);
      expect(WindowClass.fromWidth(839), WindowClass.medium);
      expect(WindowClass.fromWidth(840), WindowClass.expanded);
    });

    testWidgets(
      'an Android hinge (Surface Duo style) splits TwoPane and leaves the seam empty',
      (tester) async {
        tester.view
          ..physicalSize = const Size(1114, 720)
          ..devicePixelRatio = 1
          ..displayFeatures = const [
            DisplayFeature(
              bounds: Rect.fromLTWH(540, 0, 34, 720),
              type: DisplayFeatureType.hinge,
              state: DisplayFeatureState.unknown,
            ),
          ];
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          Builder(
            builder: (context) => MediaQuery(
              data: MediaQueryData(
                size: const Size(1114, 720),
                displayFeatures: tester.view.displayFeatures,
              ),
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: TwoPane(
                  primary: SizedBox(key: Key('list')),
                  secondary: SizedBox(key: Key('detail')),
                ),
              ),
            ),
          ),
        );
        expect(tester.getSize(find.byKey(const Key('list'))).width, 540);
        expect(tester.getTopLeft(find.byKey(const Key('detail'))).dx, 574);
      },
    );

    Future<AppWindow> windowWith(
      WidgetTester tester,
      DisplayFeatureState state,
    ) async {
      late AppWindow window;
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(
            size: const Size(673, 841),
            displayFeatures: [
              DisplayFeature(
                bounds: const Rect.fromLTWH(336, 0, 1, 841),
                type: DisplayFeatureType.fold,
                state: state,
              ),
            ],
          ),
          child: Builder(
            builder: (context) {
              window = AppWindow.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      return window;
    }

    testWidgets('a flat Galaxy Fold is one continuous screen', (tester) async {
      final w = await windowWith(tester, DisplayFeatureState.postureFlat);
      expect(w.hinge, isNull);
    });

    testWidgets('a half-open Galaxy Fold is two screens', (tester) async {
      final w = await windowWith(tester, DisplayFeatureState.postureHalfOpened);
      expect(w.hinge, isNotNull);
      expect(w.isSpannedHorizontally, isTrue);
    });

    test('a plain phone cannot show two panes; a small tablet can', () {
      expect(AppWindow.fromSize(const Size(700, 800)).canShowTwoPanes, isTrue);
      expect(AppWindow.fromSize(const Size(360, 640)).canShowTwoPanes, isFalse);
    });
  });
}
