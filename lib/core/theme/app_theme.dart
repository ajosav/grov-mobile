import 'package:material_ui/material_ui.dart';

import 'app_tokens.dart' hide formatNaira;

/// Builds light and dark [ThemeData] from the generated tokens. Widgets read
/// colours with `context.tokens` and never contain raw hex values.
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract final class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);
  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness brightness) {
    final text = _textTheme(c);
    final pillShape = const StadiumBorder();
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: c.lineStrong),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: c.flame,
            brightness: brightness,
          ).copyWith(
            primary: c.action,
            onPrimary: c.onAction,
            surface: c.surface,
            onSurface: c.ink,
            error: c.danger,
            outline: c.lineStrong,
            outlineVariant: c.line,
          ),
      extensions: [c],
      // Screens draw their own static wash (AppScreen); the scaffold is the
      // middle stop so a route push never shows a see-through page.
      scaffoldBackgroundColor: c.canvas,
      canvasColor: c.canvas,
      fontFamily: AppFonts.sans,
      textTheme: text,
      primaryTextTheme: text,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: c.ink,
        titleTextStyle: text.titleLarge,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.action,
          foregroundColor: c.onAction,
          disabledBackgroundColor: c.actionDisabled,
          disabledForegroundColor: c.onActionDisabled,
          minimumSize: const Size(AppSize.touchMin, AppSize.controlH),
          shape: pillShape,
          textStyle: text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.s5),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // Figma "Button / Outline": transparent pill, 1.25px ink border.
          backgroundColor: Colors.transparent,
          foregroundColor: c.ink,
          minimumSize: const Size(AppSize.touchMin, AppSize.controlH),
          shape: pillShape,
          side: BorderSide(color: c.ink, width: 1.25),
          textStyle: text.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.s5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.ink,
          minimumSize: const Size(AppSize.touchMin, AppSize.touchMin),
          shape: pillShape,
          textStyle: text.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpace.s4,
          vertical: AppSpace.s3,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: c.focus, width: 2),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: c.danger, width: 2),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: c.danger, width: 2),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surfaceRaised,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surfaceRaised,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => text.labelSmall!.copyWith(
            color: s.contains(WidgetState.selected)
                ? c.flameStrong
                : c.inkMuted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            size: AppSize.iconMd,
            color: s.contains(WidgetState.selected) ? c.flame : c.inkMuted,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: c.surfaceRaised,
        indicatorColor: Colors.transparent,
        selectedIconTheme: IconThemeData(color: c.flame, size: AppSize.iconMd),
        unselectedIconTheme: IconThemeData(
          color: c.inkMuted,
          size: AppSize.iconMd,
        ),
        selectedLabelTextStyle: text.labelSmall!.copyWith(color: c.flameStrong),
        unselectedLabelTextStyle: text.labelSmall!.copyWith(color: c.inkMuted),
      ),
      dividerTheme: DividerThemeData(color: c.line, space: 1, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: c.night,
        contentTextStyle: text.bodyMedium!.copyWith(color: c.onNight),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }

  /// Role mapping: display = hero naira, title = screen/section, body >= 15.
  static TextTheme _textTheme(AppColors c) => TextTheme(
    displayLarge: AppText.displayXl,
    displayMedium: AppText.displayLg,
    headlineSmall: AppText.titleLg,
    titleLarge: AppText.titleMd,
    titleMedium: AppText.titleSm,
    titleSmall: AppText.label,
    bodyLarge: AppText.bodyLg,
    bodyMedium: AppText.body,
    bodySmall: AppText.bodySm,
    labelLarge: AppText.label,
    labelMedium: AppText.label,
    labelSmall: AppText.chip,
  ).apply(bodyColor: c.ink, displayColor: c.ink);
}
