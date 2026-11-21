import 'package:app_mobile/core/config/brand_config.dart';
import 'package:app_mobile/core/theme/app_theme.dart';
import 'package:app_mobile/core/theme/app_tokens.dart';
import 'package:app_mobile/core/widgets/brand_logo.dart';
import 'package:app_mobile/features/session/presentation/pages/splash_page.dart';
import 'package:app_mobile/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
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

    testWidgets('shows a labelled progress indicator under the logo (M-045)', (
      tester,
    ) async {
      await pumpSplash(tester, AppTheme.light());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.bySemanticsLabel('Starting up'), findsOneWidget);
    });
  });
}
