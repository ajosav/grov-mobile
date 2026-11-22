import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';

import '../../features/auth/presentation/cubit/sign_on_cubit.dart';
import '../../features/auth/presentation/pages/email_code_page.dart';
import '../../features/auth/presentation/widgets/sign_in_transition.dart';
import '../../features/auth/domain/entities/registration_ticket.dart';
import '../../features/auth/presentation/pages/phone_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/verified_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/auth/presentation/cubit/email_code_cubit.dart';
import '../../features/auth/presentation/cubit/phone_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/session/domain/entities/auth_gate.dart';
import '../../features/session/presentation/pages/splash_page.dart';
import '../../features/session/presentation/cubit/session_cubit.dart';
import '../../features/session/presentation/cubit/session_state.dart';
import '../../features/settings/presentation/pages/account_page.dart';
import '../../features/settings/presentation/pages/appearance_page.dart';
import '../../features/shell/presentation/pages/app_shell_page.dart';
import '../../features/shell/presentation/widgets/app_tab.dart';
import '../../features/shell/presentation/pages/tab_placeholder_page.dart';
import 'routes.dart';
import 'stream_listenable.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter buildRouter(SessionCubit session) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    refreshListenable: StreamListenable(session.stream),
    redirect: (context, state) =>
        _redirect(session.state, state.matchedLocation),
    routes: [
      GoRoute(path: '/', redirect: (_, _) => Routes.home),
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashView()),
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => getIt<SignOnCubit>(),
          child: SignInTransitionHost(child: child),
        ),
        routes: [
          GoRoute(path: Routes.welcome, builder: (_, _) => const WelcomeView()),
          GoRoute(
            path: Routes.code,
            builder: (context, _) => BlocProvider(
              create: (context) => getIt<EmailCodeCubit>(
                param1: context.read<SignOnCubit>().state.email,
                param2: context.read<SignOnCubit>().state.codeNextSendAt,
              ),
              child: const EmailCodeView(),
            ),
          ),
          GoRoute(
            path: Routes.profile,
            // The ticket travels in `extra` and is not restorable: after a
            // process death the person verifies the email again.
            redirect: (_, state) =>
                state.extra is RegistrationTicket ? null : Routes.welcome,
            builder: (_, state) =>
                ProfileView(state.extra! as RegistrationTicket),
          ),
          GoRoute(
            path: Routes.phone,
            builder: (_, _) => BlocProvider(
              create: (_) => getIt<PhoneCubit>(),
              child: const PhoneView(),
            ),
          ),
          GoRoute(
            path: Routes.verified,
            builder: (_, _) => const VerifiedView(),
          ),
        ],
      ),
      StatefulShellRoute(
        builder: (context, state, shell) => shell,
        // Only the visible tab stays mounted (2 GB phones). Each branch keeps
        // its own navigator state, so returning restores its stack.
        navigatorContainerBuilder: (context, shell, children) => AppShellView(
          navigationShell: shell,
          child: children[shell.currentIndex],
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (_, _) => BlocProvider(
                  create: (_) => getIt<HomeCubit>()..load(),
                  child: const HomeView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.shop,
                builder: (_, _) => const TabPlaceholderView(tab: AppTab.shop),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.plan,
                builder: (_, _) => const TabPlaceholderView(tab: AppTab.plan),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.orders,
                builder: (_, _) => const TabPlaceholderView(tab: AppTab.orders),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.savings,
                builder: (_, _) =>
                    const TabPlaceholderView(tab: AppTab.savings),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.account,
        builder: (_, _) => const AccountView(),
        routes: [
          GoRoute(
            path: 'appearance',
            builder: (_, _) => const AppearanceView(),
          ),
        ],
      ),
    ],
  );
}

String? _redirect(SessionState session, String location) => switch (session) {
  SessionUnknown() => location == Routes.splash ? null : Routes.splash,
  SessionSignedOut() => _signedOut(location),
  SessionSignedIn(:final session) => _signedIn(session.gate, location),
};

const _gateScreens = {Routes.phone, Routes.verified};

String? _signedOut(String location) {
  final isSignOn =
      location.startsWith(Routes.welcome) && !_gateScreens.contains(location);
  return isSignOn ? null : Routes.welcome;
}

String? _signedIn(AuthGate gate, String location) {
  return switch (gate) {
    AuthGate.addPhone => location == Routes.phone ? null : Routes.phone,
    AuthGate.none =>
      location == Routes.code
          ? Routes.verified
          : (location == Routes.verified
                ? null
                : (location == Routes.splash ||
                          location.startsWith(Routes.welcome)
                      ? Routes.home
                      : null)),
    AuthGate.verifyEmail ||
    AuthGate.acceptTerms ||
    AuthGate.mfa ||
    AuthGate.mfaEnrol => location == Routes.welcome ? null : Routes.welcome,
  };
}
