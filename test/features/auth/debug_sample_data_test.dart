import 'package:app_mobile/core/config/brand_config.dart';
import 'package:app_mobile/core/config/debug_config.dart';
import 'package:app_mobile/core/di/injection.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/core/router/app_router.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/core/theme/app_tokens.dart';
import 'package:app_mobile/core/widgets/brand_logo.dart';
import 'package:app_mobile/features/auth/data/repositories/debug_auth_repository.dart';
import 'package:app_mobile/features/auth/data/repositories/debug_switch_auth_repository.dart';
import 'package:app_mobile/features/auth/domain/entities/new_account.dart';
import 'package:app_mobile/features/auth/domain/entities/password_problem.dart';
import 'package:app_mobile/features/auth/presentation/cubit/email_code_cubit.dart';
import 'package:app_mobile/features/auth/presentation/pages/email_code_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/join_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/password_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/verified_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/welcome_page.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';
import 'package:app_mobile/features/session/domain/repositories/session_repository.dart';
import 'package:app_mobile/features/session/presentation/pages/splash_page.dart';
import 'package:app_mobile/features/sync/domain/repositories/sync_repository.dart';
import 'package:app_mobile/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

class _Sessions() implements SessionRepository {
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

class _Sync() implements SyncRepository {
  @override
  Future<Result<bool>> isOnline() async => const Result.ok(true);
  @override
  Stream<Result<bool>> watchOnline() => Stream.value(const Result.ok(true));
  @override
  Stream<Result<DateTime?>> watchLastSyncedAt() =>
      Stream.value(const Result.ok(null));
}

DebugAuthRepository _sample() => DebugAuthRepository(latency: Duration.zero);

void main() {
  group('the sample answers follow the rules in the debug panel', () {
    late DebugAuthRepository repo;
    setUp(() => repo = _sample());

    test(
      'lookup: new by default, known / google / locked by the email',
      () async {
        expect((await repo.lookup('a@b.co')).valueOrNull?.exists, isFalse);
        final known = (await repo.lookup('known@b.co')).valueOrNull!;
        expect(known.exists && known.hasPassword, isTrue);
        final google = (await repo.lookup('google@b.co')).valueOrNull!;
        expect(google.exists, isTrue);
        expect(google.hasPassword, isFalse);
      },
    );

    test('log in: ok, wrong, locked, unverified', () async {
      final ok = (await repo.logIn('known@b.co', 'x')).valueOrNull!;
      expect(ok.session?.gate, AuthGate.none);
      expect(
        (await repo.logIn('known@b.co', 'wrong')).failureOrNull,
        isA<UnauthorizedFailure>(),
      );
      expect(
        (await repo.logIn('locked@b.co', 'x')).failureOrNull,
        isA<ForbiddenFailure>(),
      );
      final un = (await repo.logIn('unverified@b.co', 'x')).valueOrNull!;
      expect(un.session?.gate, AuthGate.verifyEmail);
      expect(un.challenge, isNotNull);
    });

    test(
      'sign up: ok is gated with a code; taken email and phone are refused',
      () async {
        NewAccount account(String email, String phone) => NewAccount(
          email: email,
          firstName: 'N',
          lastName: 'O',
          phone: phone,
          password: 'Secret!123',
        );
        final ok = (await repo.signUp(account('new@b.co', '+2348031234567')))
            .valueOrNull!;
        expect(ok.session?.gate, AuthGate.verifyEmail);
        expect(ok.session?.email, 'new@b.co');
        expect(
          (await repo.signUp(account('taken@b.co', '+2348031234567')))
              .failureOrNull,
          isA<ConflictFailure>(),
        );
        expect(
          (await repo.signUp(account('new@b.co', '+2348030000000')))
              .failureOrNull,
          isA<ConflictFailure>(),
        );
      },
    );

    test('email code: accepted, wrong, expired, locked', () async {
      expect(
        (await repo.verifyEmail('123456')).valueOrNull?.session?.gate,
        AuthGate.none,
      );
      for (final (code, want) in [
        ('111111', 'OTP_INVALID'),
        ('222222', 'OTP_EXPIRED'),
        ('000000', 'OTP_LOCKED'),
      ]) {
        final f = (await repo.verifyEmail(code)).failureOrNull;
        expect((f! as ValidationFailure).code, want);
      }
    });

    test('password check flags common passwords', () async {
      final c = (await repo.checkPassword('Password1!')).valueOrNull!;
      expect(c.problems, {PasswordProblem.common});
      expect((await repo.checkPassword('Zx9!kqLm2')).valueOrNull?.ok, isTrue);
    });

    test('reset links: good, expired, used', () async {
      expect((await repo.checkResetLink('sample-token')).valueOrNull, isTrue);
      expect((await repo.checkResetLink('expired-x')).valueOrNull, isFalse);
      expect(
        (await repo.resetPassword('used-x', 'p')).failureOrNull,
        isA<GoneFailure>(),
      );
      expect(
        (await repo.resetPassword('good', 'p')).valueOrNull?.session,
        isNotNull,
      );
    });

    test('the countdowns come from the clock it is given', () async {
      final at = DateTime.utc(2026, 11, 21, 10);
      final r = DebugAuthRepository(latency: Duration.zero, now: () => at);
      final c = (await r.resendEmailCode()).valueOrNull!;
      expect(c.nextSendAt, at.add(const Duration(seconds: 60)));
    });
  });

  group('the switch', () {
    tearDown(() => DebugConfig.sampleData.value = true);

    test('sends each call to the sample or the real repository', () async {
      final real = FakeAuthRepository();
      final switched = DebugSwitchAuthRepository(real: real, sample: _sample());

      DebugConfig.sampleData.value = true;
      await switched.lookup('a@b.co');
      expect(real.calls, isEmpty, reason: 'sample data never reaches the API');

      DebugConfig.sampleData.value = false;
      await switched.lookup('a@b.co');
      expect(real.calls, ['lookup:a@b.co']);
    });

    test('starts on in a debug build without an API address', () {
      // `flutter test` passes no API_BASE_URL and runs in debug mode.
      expect(DebugConfig.sampleData.value, isTrue);
    });
  });

  group('every screen is reachable with no backend', () {
    late GoRouterHolder holder;

    Future<void> pump(WidgetTester tester, {Session? stored}) async {
      DebugConfig.sampleData.value = true;
      tester.view
        ..physicalSize = const Size(390, 844)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final repo = _sample();
      getIt
        ..registerFactory(() => signOnCubitFor(repo))
        ..registerFactoryParam<EmailCodeCubit, String, DateTime?>(
          (e, n) => emailCodeCubitFor(repo, email: e, nextSendAt: n),
        )
        ..registerFactoryParam(
          (String e, void _) => forgotPasswordCubitFor(repo, email: e),
        )
        ..registerFactoryParam(
          (String t, void _) => resetPasswordCubitFor(repo, token: t),
        )
        ..registerFactory(() => phoneCubitFor(repo));
      addTearDown(getIt.reset);
      final sessionRepo = _Sessions()..stored = stored;
      final session = sessionCubitFor(sessionRepo);
      addTearDown(session.close);
      final router = buildRouter(session);
      addTearDown(router.dispose);
      holder = GoRouterHolder(router);
      final sync = syncStatusCubitFor(_Sync());
      addTearDown(sync.close);
      await sync.start();
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
      await session.restore();
      await tester.pumpAndSettle();
    }

    Future<void> type(WidgetTester t, int i, String s) async {
      await t.enterText(find.byType(TextField).at(i), s);
      await t.pump();
    }

    testWidgets('the debug chip shows the mode and the switch flips it', (
      tester,
    ) async {
      await pump(tester);
      expect(find.text('Debug · sample data'), findsOneWidget);
      await tester.tap(find.text('Debug · sample data'));
      await tester.pumpAndSettle();
      expect(find.text('Use sample data (no backend)'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(DebugConfig.sampleData.value, isFalse);
      // Back on the sheet: the live-API line replaces the sample line.
      expect(find.textContaining('Live API:'), findsOneWidget);
      DebugConfig.sampleData.value = true;
    });

    testWidgets('join, code 123456, "You’re in", Home', (tester) async {
      await pump(tester);
      await type(tester, 0, 'new@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(JoinView), findsOneWidget);

      await type(tester, 1, 'Ngozi');
      await type(tester, 2, 'Okafor');
      await type(tester, 3, '0803 123 4567');
      await type(tester, 4, 'Zx9!kqLm2');
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.text('Create account'));
      await tester.pumpAndSettle();

      expect(find.byType(EmailCodeView), findsOneWidget);
      await tester.enterText(find.byType(TextField), '123456');
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(VerifiedView), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(find.text('No plan yet'), findsOneWidget);
    });

    testWidgets(
      'a known email logs in; "wrong" shows the wrong-password error',
      (tester) async {
        await pump(tester);
        await type(tester, 0, 'known@example.com');
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
        expect(find.byType(PasswordView), findsOneWidget);

        await type(tester, 1, 'wrong');
        await tester.tap(find.text('Log in'));
        await tester.pumpAndSettle();
        expect(find.textContaining('isn’t right'), findsOneWidget);

        await type(tester, 1, 'Secret!123');
        await tester.tap(find.text('Log in'));
        await tester.pumpAndSettle();
        expect(find.text('No plan yet'), findsOneWidget);
      },
    );

    testWidgets('an unverified email is sent to the code screen', (
      tester,
    ) async {
      await pump(tester);
      await type(tester, 0, 'unverified@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await type(tester, 1, 'Secret!123');
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();
      expect(find.byType(EmailCodeView), findsOneWidget);
    });

    testWidgets('a Google-only email says so and stays on Welcome', (
      tester,
    ) async {
      await pump(tester);
      await type(tester, 0, 'google@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(
        find.text('This email signs in with Google or Apple.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'the reset link shortcut opens the form, and an expired one the dead end',
      (tester) async {
        await pump(tester);
        holder.router.go('/reset?token=sample-reset-token-1234567890');
        await tester.pumpAndSettle();
        expect(find.text('Set a new password'), findsOneWidget);

        holder.router.go('/reset?token=expired-sample-reset-token-12');
        await tester.pumpAndSettle();
        expect(find.text('This link has expired'), findsOneWidget);
      },
    );
  });

  group('splash', () {
    Future<void> pumpSplash(WidgetTester tester, ThemeData theme) =>
        tester.pumpWidget(
          MaterialApp(
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SplashView(),
          ),
        );

    testWidgets('shows the logo on the canvas, labelled for screen readers', (
      tester,
    ) async {
      await pumpSplash(tester, AppTheme.light());
      await tester.pump();
      expect(find.byType(BrandLogo), findsOneWidget);
      expect(find.bySemanticsLabel(BrandConfig.name), findsOneWidget);
      expect(
        tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
        AppColors.light.canvas,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('dark theme keeps the logo readable on a cream plate', (
      tester,
    ) async {
      await pumpSplash(tester, AppTheme.dark());
      await tester.pump();
      final plate = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(BrandLogo),
          matching: find.byType(DecoratedBox),
        ),
      );
      expect((plate.decoration as BoxDecoration).color, AppColors.dark.onNight);
      expect(
        tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
        AppColors.dark.canvas,
      );
    });

    testWidgets('no animation and no gradient: nothing to wait for', (
      tester,
    ) async {
      await pumpSplash(tester, AppTheme.light());
      await tester.pump();
      // One pump is the whole screen: no pending animation frames.
      expect(tester.hasRunningAnimations, isFalse);
    });
  });
}

/// Holds the router so a test can navigate it.
class GoRouterHolder(final GoRouter router);
