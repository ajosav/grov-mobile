import 'dart:async';

import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:app_mobile/core/di/injection.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/core/router/app_router.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/features/auth/presentation/cubit/email_code_cubit.dart';
import 'package:app_mobile/features/auth/presentation/pages/email_code_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/profile_page.dart';
import 'package:app_mobile/features/auth/presentation/widgets/sign_in_transition.dart';
import 'package:app_mobile/features/auth/presentation/pages/phone_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/verified_page.dart';
import 'package:app_mobile/features/auth/presentation/pages/welcome_page.dart';
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

/// Welcome -> code screen, with the email typed.
Future<void> _toCode(WidgetTester tester) async {
  _repo.requestCodeResult = Result.ok(
    challengeAt(DateTime.now().add(const Duration(seconds: 60))),
  );
  await _type(tester, 0, 'ngozi@example.com');
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
}

/// Welcome -> code -> profile screen (a new address).
Future<void> _toProfile(WidgetTester tester) async {
  _repo.verifyResult = Result.ok(profileRequired());
  await _toCode(tester);
  await tester.enterText(find.byType(TextField), '429107');
  await tester.pump();
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

Future<void> _fillProfile(WidgetTester tester) async {
  await _type(tester, 1, 'Ngozi');
  await _type(tester, 2, 'Okafor');
  await _type(tester, 3, '0803 123 4567');
  final terms = find.byType(CheckboxListTile);
  await tester.ensureVisible(terms);
  await tester.tap(terms);
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
      expect(
        find.text('We’ll email you a 6-digit code. No password needed.'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('Continue with Google'), findsOneWidget);
      // Apple's button is an iOS convention only.
      expect(find.bySemanticsLabel('Continue with Apple'), findsNothing);
      expect(find.text('Password'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('signed out cannot reach the phone or "You’re in" screens', (
      tester,
    ) async {
      await _pump(tester);
      for (final path in ['/welcome/phone', '/welcome/done']) {
        _router.go(path);
        await tester.pumpAndSettle();
        expect(find.byType(WelcomeView), findsOneWidget, reason: path);
      }
    });

    testWidgets('the code screen is reachable signed out', (tester) async {
      await _pump(tester);
      _router.go('/welcome/code');
      await tester.pumpAndSettle();
      expect(find.byType(EmailCodeView), findsOneWidget);
    });

    testWidgets('the profile screen needs a ticket, else back to Welcome', (
      tester,
    ) async {
      await _pump(tester);
      _router.go('/welcome/profile');
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(find.byType(ProfileView), findsNothing);
    });

    testWidgets('a session owing its phone lands on the phone screen', (
      tester,
    ) async {
      await _pump(tester, stored: sessionWith(AuthGate.addPhone));
      expect(find.byType(PhoneView), findsOneWidget);
      expect(find.text('One more step'), findsOneWidget);
    });

    testWidgets('a gated session cannot wander to Home', (tester) async {
      await _pump(tester, stored: sessionWith(AuthGate.addPhone));
      _router.go('/home');
      await tester.pumpAndSettle();
      expect(find.byType(PhoneView), findsOneWidget);
    });

    testWidgets('an unverified-email session is not stuck on a dead screen', (
      tester,
    ) async {
      await _pump(tester, stored: sessionWith(AuthGate.verifyEmail));
      expect(find.byType(WelcomeView), findsOneWidget);
    });

    testWidgets('a clear session skips Welcome', (tester) async {
      await _pump(tester, stored: sessionWith(AuthGate.none));
      expect(find.text('This week’s progress'), findsOneWidget);
    });
  });

  group('the passwordless flow', () {
    testWidgets('Continue asks for a code and opens the code screen', (
      tester,
    ) async {
      await _pump(tester);
      await _toCode(tester);
      expect(_repo.calls, ['requestCode:ngozi@example.com']);
      expect(find.byType(EmailCodeView), findsOneWidget);
      expect(find.text('Check your email'), findsOneWidget);
      expect(find.text('ngozi@example.com'), findsOneWidget);
      expect(find.textContaining('Resend code in'), findsOneWidget);
      expect(find.text('Use a different email'), findsOneWidget);
    });

    testWidgets('asking again too soon still opens the code screen', (
      tester,
    ) async {
      await _pump(tester);
      _repo.requestCodeResult = Result.err(
        RateLimitedFailure('x', 'OTP_RESEND_TOO_SOON', {
          'nextSendAt': DateTime.now()
              .add(const Duration(seconds: 40))
              .toUtc()
              .toIso8601String(),
        }),
      );
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(EmailCodeView), findsOneWidget);
      expect(find.textContaining('Resend code in'), findsOneWidget);
    });

    testWidgets('"Use a different email" returns to Welcome with the email', (
      tester,
    ) async {
      await _pump(tester);
      await _toCode(tester);
      await tester.tap(find.text('Use a different email'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(find.text('ngozi@example.com'), findsOneWidget);
    });

    testWidgets('an existing account: code, "You’re in", then Home', (
      tester,
    ) async {
      _repo.verifyResult = Result.ok(signedInWith(AuthGate.none));
      await _pump(tester);
      await _toCode(tester);
      await tester.enterText(find.byType(TextField), '429107');
      await tester.pump();
      await tester.pump();
      expect(_repo.calls, contains('verifyCode:ngozi@example.com:429107'));
      expect(find.text('Email verified'), findsOneWidget);
      expect(find.text('Taking you in…'), findsOneWidget);
      // Let the short hand-over delay run, then we land on "You’re in".
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(VerifiedView), findsOneWidget);
      expect(find.text('You’re in'), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(find.text('This week’s progress'), findsOneWidget);
    });

    testWidgets('a new address: code, then the profile screen', (tester) async {
      await _pump(tester);
      await _toProfile(tester);
      expect(find.byType(ProfileView), findsOneWidget);
      expect(find.text('Tell us about you'), findsOneWidget);
      expect(find.text('First name'), findsOneWidget);
      expect(find.text('Last name'), findsOneWidget);
      expect(find.text('Phone number'), findsOneWidget);
      expect(find.text('Password'), findsNothing);
      expect(find.text('ngozi@example.com'), findsOneWidget);
    });

    testWidgets('Create account waits for every field and the terms', (
      tester,
    ) async {
      await _pump(tester);
      await _toProfile(tester);
      FilledButton button() =>
          tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button().onPressed, isNull);
      await _fillProfile(tester);
      expect(button().onPressed, isNotNull);
      await _type(tester, 2, '');
      expect(button().onPressed, isNull, reason: 'last name is required');
    });

    testWidgets('creating the account covers the screen, then “You’re in”', (
      tester,
    ) async {
      final hold = Completer<void>();
      _repo.completeProfileResult = Result.ok(outcomeWith(AuthGate.none));
      await _pump(tester);
      final sessions = _sessionsRepo;
      await _toProfile(tester);
      await _fillProfile(tester);
      sessions.holdSave = hold;
      await tester.tap(find.text('Create account'));
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(_repo.lastProfile?.ticket, 'ticket-of-a-new-address');
      expect(_repo.lastProfile?.phone, '+2348031234567');
      expect(find.byType(SignInTransition), findsOneWidget);
      expect(find.text('Signing in…'), findsWidgets);

      hold.complete();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(SignInTransition), findsNothing);
      await tester.pumpAndSettle();
      // A new account lands on "You’re in" like a returning one, then Home.
      expect(find.byType(VerifiedView), findsOneWidget);
      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(find.text('This week’s progress'), findsOneWidget);
    });

    testWidgets('a phone on another account is said under the phone field', (
      tester,
    ) async {
      _repo.completeProfileResult = const Result.err(
        ConflictFailure('x', 'PHONE_TAKEN'),
      );
      await _pump(tester);
      await _toProfile(tester);
      await _fillProfile(tester);
      await tester.tap(find.text('Create account'));
      await tester.pumpAndSettle();
      expect(find.textContaining('already on an account'), findsOneWidget);
      expect(find.byType(ProfileView), findsOneWidget);
    });

    testWidgets('an expired ticket explains and goes back to Welcome', (
      tester,
    ) async {
      _repo.completeProfileResult = const Result.err(
        ValidationFailure({}, 'x', 'OTP_REGISTRATION_INVALID'),
      );
      await _pump(tester);
      await _toProfile(tester);
      await _fillProfile(tester);
      await tester.tap(find.text('Create account'));
      await tester.pumpAndSettle();
      expect(
        find.text('That sign-up timed out. Enter your email to start again.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
    });

    testWidgets('the profile back button goes to Welcome', (tester) async {
      await _pump(tester);
      await _toProfile(tester);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
    });

    testWidgets('a wrong code shows the error banner', (tester) async {
      _repo.verifyResult = const Result.err(
        ValidationFailure({}, 'x', 'OTP_INVALID'),
      );
      await _pump(tester);
      await _toCode(tester);
      await tester.enterText(find.byType(TextField), '000000');
      await tester.pumpAndSettle();
      expect(
        find.text('That code isn’t right. Check it and try again.'),
        findsOneWidget,
      );
    });

    testWidgets('a code that cannot be sent is a neutral note, not a dead end', (
      tester,
    ) async {
      _repo.requestCodeResult = const Result.err(TimeoutFailure());
      await _pump(tester);
      await _type(tester, 0, 'ngozi@example.com');
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
      expect(find.text('That took too long. Try again.'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
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

    testWidgets('200% text on a 360pt phone: Welcome, code and profile', (
      tester,
    ) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await _pump(tester, size: const Size(360, 640));
      expect(tester.takeException(), isNull);

      await _toCode(tester);
      expect(find.byType(EmailCodeView), findsOneWidget);
      expect(tester.takeException(), isNull);

      _router.go('/welcome');
      await tester.pumpAndSettle();
      await _toProfile(tester);
      expect(find.byType(ProfileView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('code and profile on a tablet', (tester) async {
      await _pump(tester, size: const Size(834, 1194));
      await _toCode(tester);
      expect(find.byType(EmailCodeView), findsOneWidget);
      expect(tester.takeException(), isNull);
      _router.go('/welcome');
      await tester.pumpAndSettle();
      await _toProfile(tester);
      expect(find.byType(ProfileView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the primary action is full width on every screen', (
      tester,
    ) async {
      // A lone button used to shrink to its label inside the actions slot.
      void expectFullWidth(String where) {
        final button = find.byType(FilledButton);
        expect(button, findsWidgets, reason: where);
        final width = tester.getSize(button.first).width;
        // 390 wide with a 20px gutter on each side.
        expect(width, closeTo(350, 1), reason: '$where: button is $width wide');
      }

      await _pump(tester);
      expectFullWidth('welcome');

      await _toCode(tester);
      expectFullWidth('code');

      _router.go('/welcome');
      await tester.pumpAndSettle();
      await _toProfile(tester);
      expectFullWidth('profile');
    });

    testWidgets('the phone button is full width too', (tester) async {
      await _pump(tester, stored: sessionWith(AuthGate.addPhone));
      expect(
        tester.getSize(find.byType(FilledButton).first).width,
        closeTo(350, 1),
      );
    });

    testWidgets(
      'a focused field keeps focus and its cursor through fold and unfold (Tier 3)',
      (tester) async {
        // Google's Tier 3 asks that typed text AND keyboard state survive a
        // fold, unfold or resize. Focus lives in the field's State: if a
        // layout switch re-creates the field, focus is lost.
        await _pump(tester);
        await _toProfile(tester);

        // Field [1] is the first name (autofocus). Type.
        await tester.tap(find.byType(TextField).at(1));
        await tester.pump();
        await tester.enterText(find.byType(TextField).at(1), 'Ngo');
        await tester.pump();
        EditableTextState editable() =>
            tester.state<EditableTextState>(find.byType(EditableText).at(1));
        expect(editable().widget.focusNode.hasFocus, isTrue);
        expect(editable().widget.controller.selection.baseOffset, 3);

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

    testWidgets('the profile form survives a fold and unfold with its text', (
      tester,
    ) async {
      await _pump(tester);
      await _toProfile(tester);
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
