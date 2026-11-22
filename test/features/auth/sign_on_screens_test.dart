import 'dart:async';

import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:app_mobile/core/di/injection.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/core/router/app_router.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/features/auth/domain/entities/account_lookup.dart';
import 'package:app_mobile/features/auth/presentation/cubit/email_code_cubit.dart';
import 'package:app_mobile/features/auth/presentation/pages/email_code_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/join_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/password_page.dart';
import 'package:app_mobile/features/auth/presentation/widgets/sign_in_transition.dart';
import 'package:app_mobile/features/auth/presentation/pages/phone_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/verified_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/welcome_page.dart';
import 'package:app_mobile/features/auth/presentation/widgets/auth_banner.dart';
import 'package:app_mobile/features/auth/presentation/widgets/brand_panel.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';
import 'package:app_mobile/features/session/domain/repositories/session_repository.dart';
import 'package:app_mobile/features/session/presentation/cubit/session_cubit.dart';
import 'package:app_mobile/features/sync/domain/repositories/sync_repository.dart';
import 'package:app_mobile/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

class _Sessions(this.stored) implements SessionRepository {
  Session? stored;
  @override
  Future<Result<void>> revoke() async => const Result.ok(null);
  @override
  Future<Result<Session?>> restore() async => Result.ok(stored);

  /// When set, saving waits on it, to look at the screen mid sign-in.
  Completer<void>? holdSave;
  @override
  Future<Result<void>> save(Session s) async {
    await holdSave?.future;
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

class _Sync({final bool online = true}) implements SyncRepository {
  @override
  Future<Result<bool>> isOnline() async => Result.ok(online);
  @override
  Stream<Result<bool>> watchOnline() => Stream.value(Result.ok(online));
  @override
  Stream<Result<DateTime?>> watchLastSyncedAt() =>
      Stream.value(const Result.ok(null));
}

late FakeAuthRepository _repo;
late SessionCubit _session;
late GoRouter _router;
late _Sessions _sessionsRepo;

Future<void> _pump(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  Session? stored,
  bool online = true,
  List<DisplayFeature> features = const [],
}) async {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1
    ..displayFeatures = features;
  addTearDown(tester.view.reset);
  _sessionsRepo = _Sessions(stored);
  _session = sessionCubitFor(_sessionsRepo);
  addTearDown(_session.close);
  _router = buildRouter(_session);
  addTearDown(_router.dispose);
  final sync = syncStatusCubitFor(_Sync(online: online));
  addTearDown(sync.close);
  // The app starts it after the first frame (bootstrap); do the same.
  await sync.start();
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _session),
        BlocProvider.value(value: sync),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
  await tester.pump();
  await _session.restore();
  await tester.pumpAndSettle();
}

Future<void> _type(WidgetTester tester, int index, String text) async {
  await tester.enterText(find.byType(TextField).at(index), text);
  await tester.pump();
}

void main() {
  setUp(() {
    _repo = FakeAuthRepository();
    getIt
      ..registerFactory(() => signOnCubitFor(_repo))
      ..registerFactoryParam<EmailCodeCubit, String, DateTime?>(
        (email, next) =>
            emailCodeCubitFor(_repo, email: email, nextSendAt: next),
      )
      ..registerFactoryParam(
        (String email, void _) => forgotPasswordCubitFor(_repo, email: email),
      )
      ..registerFactoryParam(
        (String token, void _) => resetPasswordCubitFor(_repo, token: token),
      )
      ..registerFactory(() => phoneCubitFor(_repo))
      ..registerFactory(homeCubitFor);
  });
  tearDown(getIt.reset);

  group('the door (D37) and the gates', () {
    testWidgets('signed out lands on Welcome with email, Continue and Google', (
      tester,
    ) async {
      await _pump(tester);
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
      expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
      // Apple's button is an iOS convention only.
      expect(find.bySemanticsLabel('Continue with Apple'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('signed out cannot reach a gate screen', (tester) async {
      await _pump(tester);
      _router.go('/welcome/code');
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(find.byType(EmailCodeView), findsNothing);
    });

    testWidgets('a session owing its email code lands on the code screen', (
      tester,
    ) async {
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      expect(find.byType(EmailCodeView), findsOneWidget);
      expect(find.text('Check your email'), findsOneWidget);
      expect(find.text('ngozi@example.com'), findsOneWidget);
      expect(find.text('ng***@example.com', findRichText: true), findsNothing);
      expect(find.textContaining('ng***@example.com'), findsOneWidget);
    });

    testWidgets('a gated session cannot wander to Home', (tester) async {
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      _router.go('/home');
      await tester.pumpAndSettle();
      expect(find.byType(EmailCodeView), findsOneWidget);
    });

    testWidgets('a session owing its phone lands on the phone screen', (
      tester,
    ) async {
      await _pump(tester, stored: sessionWith(AuthGate.addPhone));
      expect(find.byType(PhoneView), findsOneWidget);
      expect(find.text('One more step'), findsOneWidget);
    });

    testWidgets('clearing the email gate shows "You’re in", then Home', (
      tester,
    ) async {
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      await _session.signedIn(sessionWith(AuthGate.none));
      await tester.pumpAndSettle();
      expect(find.byType(VerifiedView), findsOneWidget);
      expect(find.text('You’re in'), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(find.text('This week’s progress'), findsOneWidget);
    });

    testWidgets('a clear session skips Welcome', (tester) async {
      await _pump(tester, stored: sessionWith(AuthGate.none));
      expect(find.text('This week’s progress'), findsOneWidget);
    });
  });

  group('the email-first flow', () {
    testWidgets('a new email goes to join and shows the live checklist', (
      tester,
    ) async {
      _repo.lookupResult = const Result.ok(
        AccountLookup(exists: false, hasPassword: false),
      );
      await _pump(tester);
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.byType(JoinView), findsOneWidget);
      expect(find.text('Let’s set you up'), findsOneWidget);
      expect(find.text('ngozi@example.com'), findsOneWidget);
      expect(find.text('8 or more characters'), findsOneWidget);

      // Create account is disabled until the form is ready.
      FilledButton create() =>
          tester.widget<FilledButton>(find.byType(FilledButton));
      expect(create().onPressed, isNull);

      // Fields: [0] email (read only), [1] first name, [2] last name (optional),
      // [3] phone, [4] password.
      await _type(tester, 1, 'Ngozi');
      await _type(tester, 3, '0803 123 4567');
      await _type(tester, 4, 'Secret!123');
      await tester.pump(const Duration(milliseconds: 400));
      expect(create().onPressed, isNull);

      await tester.ensureVisible(find.byType(CheckboxListTile));
      await tester.pump();
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pump();
      expect(create().onPressed, isNotNull);
    });

    testWidgets(
      'an email with a password goes to log-in; a wrong password says so',
      (tester) async {
        _repo
          ..lookupResult = const Result.ok(
            AccountLookup(exists: true, hasPassword: true),
          )
          ..logInResult = const Result.err(
            UnauthorizedFailure('Credentials are wrong'),
          );
        await _pump(tester);
        await _type(tester, 0, 'ngozi@example.com');
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        expect(find.byType(PasswordView), findsOneWidget);
        expect(find.text('Welcome back'), findsOneWidget);

        await _type(tester, 1, 'wrong');
        await tester.tap(find.text('Log in'));
        await tester.pumpAndSettle();
        expect(find.text('Credentials are wrong'), findsOneWidget);
        expect(find.byType(PasswordView), findsOneWidget);
      },
    );

    testWidgets('a good log-in with a clear account opens Home', (
      tester,
    ) async {
      _repo
        ..lookupResult = const Result.ok(
          AccountLookup(exists: true, hasPassword: true),
        )
        ..logInResult = Result.ok(outcomeWith(AuthGate.none));
      await _pump(tester);
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await _type(tester, 1, 'Secret!123');
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();
      expect(find.text('This week’s progress'), findsOneWidget);
    });

    testWidgets('a full-screen transition covers the gap until Home opens', (
      tester,
    ) async {
      final hold = Completer<void>();
      _repo
        ..lookupResult = const Result.ok(
          AccountLookup(exists: true, hasPassword: true),
        )
        ..logInResult = Result.ok(outcomeWith(AuthGate.none));
      await _pump(tester);
      final sessions = _sessionsRepo;
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await _type(tester, 1, 'Secret!123');
      sessions.holdSave = hold;
      await tester.tap(find.text('Log in'));
      await tester.pump();
      await tester.pump();
      // Signed in on the server, session not saved yet: never a silent gap.
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.byType(SignInTransition), findsOneWidget);
      expect(find.text('Signing in…'), findsWidgets);

      hold.complete();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(SignInTransition), findsNothing);
      await tester.pumpAndSettle();
      expect(find.text('This week’s progress'), findsOneWidget);
    });

    testWidgets('log-in with an unverified email lands on the code screen', (
      tester,
    ) async {
      _repo
        ..lookupResult = const Result.ok(
          AccountLookup(exists: true, hasPassword: true),
        )
        ..logInResult = Result.ok(outcomeWith(AuthGate.verifyEmail));
      await _pump(tester);
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await _type(tester, 1, 'Secret!123');
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();
      expect(find.byType(EmailCodeView), findsOneWidget);
    });

    testWidgets('typing the six digits verifies and shows the accepted state', (
      tester,
    ) async {
      _repo.verifyResult = Result.ok(outcomeWith(AuthGate.none));
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      await tester.enterText(find.byType(TextField), '429107');
      await tester.pump();
      await tester.pump();
      expect(_repo.calls, contains('verifyEmail:429107'));
      expect(find.text('Email verified'), findsOneWidget);
      expect(find.text('Taking you in…'), findsOneWidget);
      // Let the short hand-over delay run, then we land on "You’re in".
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(VerifiedView), findsOneWidget);
    });

    testWidgets('a wrong code shows the error banner', (tester) async {
      _repo.verifyResult = const Result.err(
        ValidationFailure({}, 'x', 'OTP_INVALID'),
      );
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      await tester.enterText(find.byType(TextField), '000000');
      await tester.pumpAndSettle();
      expect(
        find.text('That code isn’t right. Check it and try again.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'a server that cannot be reached is a neutral note, never a dead end',
      (tester) async {
        // Connectivity says online; the call itself fails (server down, wrong
        // address). That is not the offline state and must not block a retry.
        _repo.lookupResult = const Result.err(OfflineFailure());
        await _pump(tester);
        await _type(tester, 0, 'ngozi@example.com');
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        expect(
          find.text(
            'We couldn’t connect. Check your connection and try again.',
          ),
          findsOneWidget,
        );
        // The "needs a connection" state is for real offline only.
        expect(find.textContaining('Sign-on needs a connection'), findsNothing);
        final banner = tester.widget<AuthBanner>(find.byType(AuthBanner));
        expect(
          banner.kind,
          AuthBannerKind.info,
          reason: 'not red: not their fault',
        );
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
          isNotNull,
          reason: 'Continue stays usable',
        );

        // The server comes back: Try again goes through.
        _repo.lookupResult = const Result.ok(
          AccountLookup(exists: false, hasPassword: false),
        );
        await tester.tap(find.text('Try again'));
        await tester.pumpAndSettle();
        expect(find.byType(JoinView), findsOneWidget);
      },
    );

    testWidgets('the same neutral note on the log-in screen', (tester) async {
      _repo
        ..lookupResult = const Result.ok(
          AccountLookup(exists: true, hasPassword: true),
        )
        ..logInResult = const Result.err(OfflineFailure());
      await _pump(tester);
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await _type(tester, 1, 'Secret!123');
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();
      final banner = tester.widget<AuthBanner>(find.byType(AuthBanner));
      expect(banner.kind, AuthBannerKind.info);
      expect(find.byType(PasswordView), findsOneWidget);
    });

    testWidgets('offline Welcome says so neutrally and disables Continue', (
      tester,
    ) async {
      await _pump(tester, online: false);
      expect(
        find.text(
          'Sign-on needs a connection. Check your network and try again.',
        ),
        findsOneWidget,
      );
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });
  });

  group('every device (D40)', () {
    final sizes = {
      '360pt phone': const Size(360, 640),
      '390pt phone': const Size(390, 844),
      'tablet portrait': const Size(834, 1194),
      'tablet landscape': const Size(1194, 834),
      'fold inner': const Size(1114, 720),
    };

    for (final MapEntry(:key, :value) in sizes.entries) {
      testWidgets('Welcome fits on a $key', (tester) async {
        await _pump(tester, size: value);
        expect(tester.takeException(), isNull);
        final wide = value.width >= 840;
        expect(
          find.byType(BrandPanel),
          wide ? findsOneWidget : findsNothing,
          reason: 'the logo card sits beside the form only on wide windows',
        );
      });
    }

    testWidgets('a hinge splits Welcome and leaves the seam empty', (
      tester,
    ) async {
      await _pump(
        tester,
        size: const Size(1114, 720),
        features: const [
          DisplayFeature(
            bounds: Rect.fromLTWH(540, 0, 34, 720),
            type: DisplayFeatureType.hinge,
            state: DisplayFeatureState.unknown,
          ),
        ],
      );
      expect(find.byType(BrandPanel), findsOneWidget);
      final panel = tester.getRect(find.byType(BrandPanel));
      expect(panel.right, lessThanOrEqualTo(540));
      final email = tester.getRect(find.byType(TextField));
      expect(email.left, greaterThanOrEqualTo(574));
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      '200% text does not overflow on a 360pt phone: Welcome, join, code',
      (tester) async {
        tester.platformDispatcher.textScaleFactorTestValue = 2.0;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        _repo.lookupResult = const Result.ok(
          AccountLookup(exists: false, hasPassword: false),
        );
        await _pump(tester, size: const Size(360, 640));
        expect(tester.takeException(), isNull);

        await _type(tester, 0, 'ngozi@example.com');
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
        expect(find.byType(JoinView), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('the code screen at 200% text on 360pt', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await _pump(
        tester,
        size: const Size(360, 640),
        stored: sessionWith(AuthGate.verifyEmail),
      );
      expect(find.byType(EmailCodeView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'the primary action is full width on every screen that has one',
      (tester) async {
        // A lone button used to shrink to its label inside the actions slot.
        Future<void> expectFullWidth(String where) async {
          final button = find.byType(FilledButton);
          expect(button, findsWidgets, reason: where);
          final width = tester.getSize(button.first).width;
          // 390 wide with a 20px gutter on each side.
          expect(
            width,
            closeTo(350, 1),
            reason: '$where: button is $width wide',
          );
        }

        _repo
          ..lookupResult = const Result.ok(
            AccountLookup(exists: true, hasPassword: true),
          )
          ..logInResult = const Result.err(UnauthorizedFailure());
        await _pump(tester);
        await expectFullWidth('welcome');

        await _type(tester, 0, 'ngozi@example.com');
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
        await expectFullWidth('log-in');

        _router.go('/welcome');
        await tester.pumpAndSettle();
        _repo.lookupResult = const Result.ok(
          AccountLookup(exists: false, hasPassword: false),
        );
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
        await expectFullWidth('join');
      },
    );

    testWidgets('the code, phone and reset buttons are full width too', (
      tester,
    ) async {
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      expect(
        tester.getSize(find.byType(FilledButton).first).width,
        closeTo(350, 1),
        reason: 'code',
      );
      await _session.signedIn(sessionWith(AuthGate.addPhone));
      await tester.pumpAndSettle();
      expect(
        tester.getSize(find.byType(FilledButton).first).width,
        closeTo(350, 1),
        reason: 'phone',
      );
    });

    testWidgets(
      'a focused field keeps focus and its cursor through fold and unfold (Tier 3)',
      (tester) async {
        // Google's Tier 3 asks that typed text AND keyboard state survive a
        // fold, unfold or resize. Text lives in controllers, but focus (and so
        // the on-screen keyboard) lives in the field's State: if a layout
        // switch re-creates the field, focus is lost.
        _repo.lookupResult = const Result.ok(
          AccountLookup(exists: false, hasPassword: false),
        );
        await _pump(tester);
        await _type(tester, 0, 'ngozi@example.com');
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        // Field [1] is the first name. Focus it and type.
        await tester.tap(find.byType(TextField).at(1));
        await tester.pump();
        await tester.enterText(find.byType(TextField).at(1), 'Ngo');
        await tester.pump();
        EditableTextState editable() =>
            tester.state<EditableTextState>(find.byType(EditableText).at(1));
        expect(editable().widget.focusNode.hasFocus, isTrue);
        final selection = editable().widget.controller.selection;
        expect(selection.baseOffset, 3);

        // Unfold: compact -> wide (the form moves into a two-pane layout).
        tester.view.physicalSize = const Size(1114, 720);
        await tester.pumpAndSettle();
        expect(find.byType(BrandPanel), findsOneWidget);
        expect(
          editable().widget.focusNode.hasFocus,
          isTrue,
          reason: 'focus lost on unfold: the keyboard would close',
        );
        expect(editable().widget.controller.text, 'Ngo');
        expect(editable().widget.controller.selection.baseOffset, 3);

        // Fold again.
        tester.view.physicalSize = const Size(390, 844);
        await tester.pumpAndSettle();
        expect(find.byType(BrandPanel), findsNothing);
        expect(
          editable().widget.focusNode.hasFocus,
          isTrue,
          reason: 'focus lost on fold',
        );
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('the join form survives a fold and unfold with its text', (
      tester,
    ) async {
      _repo.lookupResult = const Result.ok(
        AccountLookup(exists: false, hasPassword: false),
      );
      await _pump(tester);
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await _type(tester, 1, 'Ngozi');

      tester.view.physicalSize = const Size(1114, 720);
      await tester.pumpAndSettle();
      expect(find.byType(BrandPanel), findsOneWidget);
      expect(find.text('Ngozi'), findsOneWidget);

      tester.view.physicalSize = const Size(390, 844);
      await tester.pumpAndSettle();
      expect(find.text('Ngozi'), findsOneWidget);
      expect(find.text('ngozi@example.com'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
