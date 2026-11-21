// GENERATED from design/system/tokens.json by design/tools/gen_dart_tokens.py. Do not edit by hand.
// The app design tokens for Flutter: colours per theme (ThemeExtension), spacing, radii, sizes, type.
import 'package:material_ui/material_ui.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.flame,
    required this.flameStrong,
    required this.flameTint,
    required this.night,
    required this.onNight,
    required this.onNightMuted,
    required this.action,
    required this.onAction,
    required this.codeGround,
    required this.codeInk,
    required this.leaf,
    required this.leafStrong,
    required this.leafTint,
    required this.palm,
    required this.palmStrong,
    required this.palmTint,
    required this.skyStrong,
    required this.skyTint,
    required this.danger,
    required this.dangerTint,
    required this.canvas,
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceSunken,
    required this.ink,
    required this.inkMuted,
    required this.onBright,
    required this.line,
    required this.lineStrong,
    required this.focus,
    required this.scrim,
    required this.washStart,
    required this.washEnd,
    required this.glass,
    required this.glassStrong,
    required this.glassStroke,
    required this.glassEdge,
    required this.nightHi,
    required this.actionDisabled,
    required this.onActionDisabled,
    required this.tintProduce,
    required this.tintGrain,
    required this.tintOil,
    required this.tintPackage,
    required this.tintProtein,
    required this.foodYam,
    required this.mapGround,
    required this.mapRoad,
    required this.mapBlock,
    required this.mapPin,
    required this.mapPinRing,
    required this.mapPinDot,
    required this.mapShadow,
    required this.actionHover,
    required this.actionPressed,
  });

  /// Brand orange: active tab, progress, links and actions in motion, the wordmark "o". Never the primary button fill; selected controls (radios, tiles, chips, switches) use `ink`, so orange keeps meaning "do this now". Always carries `on-bright` text (6.0:1 light, 6.7:1 dark), never white (white is 3.2:1).
  final Color flame;

  /// Orange as text or icon: links, 'Price changed' chip text, deadline countdowns. 5.4:1 on `canvas`, 5.8:1 on `surface`, 4.9:1 on `flame-tint` (light); 7.6:1 on `surface` (dark).
  final Color flameStrong;

  /// Soft orange ground: 'Price changed' chips, pool cards, promo strips, text selection. Not a selected-state fill (selection is ink). Text on it is `flame-strong` or `ink`.
  final Color flameTint;

  /// True-black colour field for money heroes and welcome, from the cream/black/orange reference. Text on it is `on-night`. Dark theme: #1C1C1C, a step above the true-black canvas so the fold still reads.
  final Color night;

  /// Text and icons on `night` (16:1+).
  final Color onNight;

  /// Secondary text on `night` fields: labels, budget lines, subtitles (about 9.7:1 on night).
  final Color onNightMuted;

  /// Primary pill fill and selected-control fill (radios, chips, segments, checkboxes). Inverts in dark: cream pill on black.
  final Color action;

  /// Text and icons on `action`.
  final Color onAction;

  /// Always-white ground behind the handover QR code in both themes, so riders' scanners read it.
  final Color codeGround;

  /// QR modules; always black on `code-ground`.
  final Color codeInk;

  /// Green, now semantic only: Locked, Paid, Delivered, done states and the logo leaf. Not a brand fill for buttons. Carries `on-bright` text (7.1:1 / 9.1:1).
  final Color leaf;

  /// Green as text: 'Locked' chip text, success words. 5.0:1 on `canvas`, 4.6:1 on `leaf-tint` (light); 9.9:1 on `surface` (dark).
  final Color leafStrong;

  /// Ground for 'Locked' chips and success banners.
  final Color leafTint;

  /// Palm-oil yellow: savings, goals, celebrations. Carries `on-bright` text (12.3:1 / 12.6:1).
  final Color palm;

  /// Yellow family as text: 'Estimate' chip text, savings amounts. 5.6:1 on `canvas` light, 12.5:1 on `surface` dark.
  final Color palmStrong;

  /// Ground for 'Estimate' chips, savings cards and goal tags. `palm-strong` on it is 6.3:1.
  final Color palmTint;

  /// Information text and icons: info and offline banners, 'Why this?' links. 5.6:1 on `canvas` light, 8.5:1 on `surface` dark.
  final Color skyStrong;

  /// Info and offline banner ground; `sky-strong` on it is 5.1:1 / 7.0:1.
  final Color skyTint;

  /// Real errors only: failed payment, failed drop charge, invalid input, out of stock. Crimson, kept apart from brand orange by hue and by always pairing an icon and a word. 6.5:1 on `canvas` light, 7.1:1 on `surface` dark. Never used for budget overage.
  final Color danger;

  /// Error banner and failed-drop ground; `danger` on it is 5.8:1 / 6.3:1.
  final Color dangerTint;

  /// Cream app background sampled from the colour-preference reference. Dark: true black.
  final Color canvas;

  /// Cards, list groups, inputs.
  final Color surface;

  /// Bottom sheets, menus, sticky action bar.
  final Color surfaceRaised;

  /// Soft sunken wells: tracks, OTP cells, inputs at rest, neutral chips, the budget note.
  final Color surfaceSunken;

  /// Primary text on `canvas`, `surface`, `surface-sunken` and every tint (16:1+). True black from the colour-preference reference.
  final Color ink;

  /// Secondary text: units, equivalents, timestamps, helper text. ≥4.5:1 on `canvas` and `surface`.
  final Color inkMuted;

  /// Text and icons on `flame`, `leaf` and `palm` fills. The app never puts white text on its bright colours.
  final Color onBright;

  /// Dividers and card outlines that carry no meaning.
  final Color line;

  /// Borders that must be seen: inputs, unselected tiles, stepper buttons (4.4:1 / 4.4:1).
  final Color lineStrong;

  /// Focus ring: 2px solid, 2px offset, every interactive element.
  final Color focus;

  /// Behind bottom sheets and dialogs.
  final Color scrim;

  /// App background wash (all screens, 23 Oct 2026): start/end stops of the static diagonal gradient; the middle stop is canvas.
  final Color washStart;

  /// App background wash (all screens, 23 Oct 2026): start/end stops of the static diagonal gradient; the middle stop is canvas.
  final Color washEnd;

  /// Frosted card fill over a colour field. High-opacity white so type stays 4.5:1+; 20px blur on capable devices.
  final Color glass;

  /// Denser frost for overlapping sheets, the floating nav and the action bar.
  final Color glassStrong;

  /// 1px inner highlight on glass edges; this is what makes it read as frost.
  final Color glassStroke;

  /// Hairline outside the highlight so glass keeps its edge on pale fields.
  final Color glassEdge;

  /// Slight lift on night colour fields, not a warm brown glow.
  final Color nightHi;

  /// Fill of a disabled primary or dark button. Solid, never 40% opacity, so it stays opaque over the wash. Always paired with `on-action-disabled`.
  final Color actionDisabled;

  /// Label and icon on a disabled button (5.5:1 light, 6.6:1 dark on `action-disabled`).
  final Color onActionDisabled;

  /// Alias of `flame-tint`. Produce category wash.
  final Color tintProduce;

  /// Alias of `palm-tint`. Grains category wash.
  final Color tintGrain;

  /// Alias of `palm-tint`. Oils category wash.
  final Color tintOil;

  /// Alias of `leaf-tint`. Packaged-food category wash.
  final Color tintPackage;

  /// Protein category wash.
  final Color tintProtein;

  /// Yam illustration brown. Illustration only, never text.
  final Color foodYam;

  /// Map base layer.
  final Color mapGround;

  /// Map roads.
  final Color mapRoad;

  /// Map city blocks.
  final Color mapBlock;

  /// Map pin body.
  final Color mapPin;

  /// Map pin outline.
  final Color mapPinRing;

  /// Map pin centre dot.
  final Color mapPinDot;

  /// Map pin shadow base colour (used at low opacity).
  final Color mapShadow;

  /// Hover fill of the primary action on web. One step off `action` in the direction of the surface it sits on.
  final Color actionHover;

  /// Pressed fill of the primary action. Paired with a 1px drop, no shadow.
  final Color actionPressed;

  static const light = AppColors(
    flame: Color(0xFFFF550C),
    flameStrong: Color(0xFFB83A06),
    flameTint: Color(0xFFFFE9E0),
    night: Color(0xFF0B0B0B),
    onNight: Color(0xFFF7F5F0),
    onNightMuted: Color(0xB8F7F5F0),
    action: Color(0xFF0B0B0B),
    onAction: Color(0xFFF7F5F0),
    codeGround: Color(0xFFFFFFFF),
    codeInk: Color(0xFF0B0B0B),
    leaf: Color(0xFF2FB36B),
    leafStrong: Color(0xFF1E7A45),
    leafTint: Color(0xFFE2F3E6),
    palm: Color(0xFFFFC72C),
    palmStrong: Color(0xFF8A5A00),
    palmTint: Color(0xFFFFF1C7),
    skyStrong: Color(0xFF1D5BD8),
    skyTint: Color(0xFFE8EEFB),
    danger: Color(0xFFB3123A),
    dangerTint: Color(0xFFFCE6EA),
    canvas: Color(0xFFF7F5F0),
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFF0EEE8),
    ink: Color(0xFF0B0B0B),
    inkMuted: Color(0xFF5A574E),
    onBright: Color(0xFF0B0B0B),
    line: Color(0xFFE8E5DC),
    lineStrong: Color(0xFF6F6B60),
    focus: Color(0xFF0B0B0B),
    scrim: Color(0x800B0B0B),
    washStart: Color(0xFFFFE9E0),
    washEnd: Color(0xFFFFF3ED),
    glass: Color(0xC7FFFFFF),
    glassStrong: Color(0xEBFFFFFF),
    glassStroke: Color(0xF2FFFFFF),
    glassEdge: Color(0x0F0B0B0B),
    nightHi: Color(0xFF1A1A1A),
    actionDisabled: Color(0xFFE8E5DC),
    onActionDisabled: Color(0xFF5A574E),
    tintProduce: Color(0xFFFFE9E0),
    tintGrain: Color(0xFFFFF1C7),
    tintOil: Color(0xFFFFF1C7),
    tintPackage: Color(0xFFE2F3E6),
    tintProtein: Color(0xFFFAE3E0),
    foodYam: Color(0xFF8A5A00),
    mapGround: Color(0xFFF0EEE8),
    mapRoad: Color(0xFFFFFFFF),
    mapBlock: Color(0xFFF7F5F0),
    mapPin: Color(0xFF0B0B0B),
    mapPinRing: Color(0xFFFFFFFF),
    mapPinDot: Color(0xFFFF550C),
    mapShadow: Color(0xFF0B0B0B),
    actionHover: Color(0xFF262626),
    actionPressed: Color(0xFF000000),
  );

  static const dark = AppColors(
    flame: Color(0xFFFF6A2B),
    flameStrong: Color(0xFFFF8A55),
    flameTint: Color(0xFF3A1E10),
    night: Color(0xFF1C1C1C),
    onNight: Color(0xFFF7F5F0),
    onNightMuted: Color(0xB8F7F5F0),
    action: Color(0xFFF7F5F0),
    onAction: Color(0xFF0B0B0B),
    codeGround: Color(0xFFFFFFFF),
    codeInk: Color(0xFF0B0B0B),
    leaf: Color(0xFF3CCB7A),
    leafStrong: Color(0xFF5FD892),
    leafTint: Color(0xFF15301F),
    palm: Color(0xFFFFD45C),
    palmStrong: Color(0xFFFFD45C),
    palmTint: Color(0xFF3A3115),
    skyStrong: Color(0xFF8DB3FF),
    skyTint: Color(0xFF1A2846),
    danger: Color(0xFFFF7A8F),
    dangerTint: Color(0xFF3D1720),
    canvas: Color(0xFF0B0B0B),
    surface: Color(0xFF161616),
    surfaceRaised: Color(0xFF1A1A1A),
    surfaceSunken: Color(0xFF111111),
    ink: Color(0xFFF7F5F0),
    inkMuted: Color(0xFFB8B4A8),
    onBright: Color(0xFF0B0B0B),
    line: Color(0xFF2A2A2A),
    lineStrong: Color(0xFF8A867A),
    focus: Color(0xFFF7F5F0),
    scrim: Color(0x99000000),
    washStart: Color(0xFF241510),
    washEnd: Color(0xFF120C09),
    glass: Color(0xB8161616),
    glassStrong: Color(0xE0161616),
    glassStroke: Color(0x1FFFFFFF),
    glassEdge: Color(0x59000000),
    nightHi: Color(0xFF262626),
    actionDisabled: Color(0xFF2A2A2A),
    onActionDisabled: Color(0xFFB8B4A8),
    tintProduce: Color(0xFF3A1E10),
    tintGrain: Color(0xFF3A3115),
    tintOil: Color(0xFF3A3115),
    tintPackage: Color(0xFF15301F),
    tintProtein: Color(0xFF341A19),
    foodYam: Color(0xFF8A5A00),
    mapGround: Color(0xFF111111),
    mapRoad: Color(0xFF262626),
    mapBlock: Color(0xFF161616),
    mapPin: Color(0xFFFF6A2B),
    mapPinRing: Color(0xFF0B0B0B),
    mapPinDot: Color(0xFF0B0B0B),
    mapShadow: Color(0xFF000000),
    actionHover: Color(0xFFFFFFFF),
    actionPressed: Color(0xFFE8E5DC),
  );

  @override
  AppColors copyWith({
    Color? flame,
    Color? flameStrong,
    Color? flameTint,
    Color? night,
    Color? onNight,
    Color? onNightMuted,
    Color? action,
    Color? onAction,
    Color? codeGround,
    Color? codeInk,
    Color? leaf,
    Color? leafStrong,
    Color? leafTint,
    Color? palm,
    Color? palmStrong,
    Color? palmTint,
    Color? skyStrong,
    Color? skyTint,
    Color? danger,
    Color? dangerTint,
    Color? canvas,
    Color? surface,
    Color? surfaceRaised,
    Color? surfaceSunken,
    Color? ink,
    Color? inkMuted,
    Color? onBright,
    Color? line,
    Color? lineStrong,
    Color? focus,
    Color? scrim,
    Color? washStart,
    Color? washEnd,
    Color? glass,
    Color? glassStrong,
    Color? glassStroke,
    Color? glassEdge,
    Color? nightHi,
    Color? actionDisabled,
    Color? onActionDisabled,
    Color? tintProduce,
    Color? tintGrain,
    Color? tintOil,
    Color? tintPackage,
    Color? tintProtein,
    Color? foodYam,
    Color? mapGround,
    Color? mapRoad,
    Color? mapBlock,
    Color? mapPin,
    Color? mapPinRing,
    Color? mapPinDot,
    Color? mapShadow,
    Color? actionHover,
    Color? actionPressed,
  }) => AppColors(
    flame: flame ?? this.flame,
    flameStrong: flameStrong ?? this.flameStrong,
    flameTint: flameTint ?? this.flameTint,
    night: night ?? this.night,
    onNight: onNight ?? this.onNight,
    onNightMuted: onNightMuted ?? this.onNightMuted,
    action: action ?? this.action,
    onAction: onAction ?? this.onAction,
    codeGround: codeGround ?? this.codeGround,
    codeInk: codeInk ?? this.codeInk,
    leaf: leaf ?? this.leaf,
    leafStrong: leafStrong ?? this.leafStrong,
    leafTint: leafTint ?? this.leafTint,
    palm: palm ?? this.palm,
    palmStrong: palmStrong ?? this.palmStrong,
    palmTint: palmTint ?? this.palmTint,
    skyStrong: skyStrong ?? this.skyStrong,
    skyTint: skyTint ?? this.skyTint,
    danger: danger ?? this.danger,
    dangerTint: dangerTint ?? this.dangerTint,
    canvas: canvas ?? this.canvas,
    surface: surface ?? this.surface,
    surfaceRaised: surfaceRaised ?? this.surfaceRaised,
    surfaceSunken: surfaceSunken ?? this.surfaceSunken,
    ink: ink ?? this.ink,
    inkMuted: inkMuted ?? this.inkMuted,
    onBright: onBright ?? this.onBright,
    line: line ?? this.line,
    lineStrong: lineStrong ?? this.lineStrong,
    focus: focus ?? this.focus,
    scrim: scrim ?? this.scrim,
    washStart: washStart ?? this.washStart,
    washEnd: washEnd ?? this.washEnd,
    glass: glass ?? this.glass,
    glassStrong: glassStrong ?? this.glassStrong,
    glassStroke: glassStroke ?? this.glassStroke,
    glassEdge: glassEdge ?? this.glassEdge,
    nightHi: nightHi ?? this.nightHi,
    actionDisabled: actionDisabled ?? this.actionDisabled,
    onActionDisabled: onActionDisabled ?? this.onActionDisabled,
    tintProduce: tintProduce ?? this.tintProduce,
    tintGrain: tintGrain ?? this.tintGrain,
    tintOil: tintOil ?? this.tintOil,
    tintPackage: tintPackage ?? this.tintPackage,
    tintProtein: tintProtein ?? this.tintProtein,
    foodYam: foodYam ?? this.foodYam,
    mapGround: mapGround ?? this.mapGround,
    mapRoad: mapRoad ?? this.mapRoad,
    mapBlock: mapBlock ?? this.mapBlock,
    mapPin: mapPin ?? this.mapPin,
    mapPinRing: mapPinRing ?? this.mapPinRing,
    mapPinDot: mapPinDot ?? this.mapPinDot,
    mapShadow: mapShadow ?? this.mapShadow,
    actionHover: actionHover ?? this.actionHover,
    actionPressed: actionPressed ?? this.actionPressed,
  );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      flame: Color.lerp(flame, other.flame, t)!,
      flameStrong: Color.lerp(flameStrong, other.flameStrong, t)!,
      flameTint: Color.lerp(flameTint, other.flameTint, t)!,
      night: Color.lerp(night, other.night, t)!,
      onNight: Color.lerp(onNight, other.onNight, t)!,
      onNightMuted: Color.lerp(onNightMuted, other.onNightMuted, t)!,
      action: Color.lerp(action, other.action, t)!,
      onAction: Color.lerp(onAction, other.onAction, t)!,
      codeGround: Color.lerp(codeGround, other.codeGround, t)!,
      codeInk: Color.lerp(codeInk, other.codeInk, t)!,
      leaf: Color.lerp(leaf, other.leaf, t)!,
      leafStrong: Color.lerp(leafStrong, other.leafStrong, t)!,
      leafTint: Color.lerp(leafTint, other.leafTint, t)!,
      palm: Color.lerp(palm, other.palm, t)!,
      palmStrong: Color.lerp(palmStrong, other.palmStrong, t)!,
      palmTint: Color.lerp(palmTint, other.palmTint, t)!,
      skyStrong: Color.lerp(skyStrong, other.skyStrong, t)!,
      skyTint: Color.lerp(skyTint, other.skyTint, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerTint: Color.lerp(dangerTint, other.dangerTint, t)!,
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      surfaceSunken: Color.lerp(surfaceSunken, other.surfaceSunken, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      onBright: Color.lerp(onBright, other.onBright, t)!,
      line: Color.lerp(line, other.line, t)!,
      lineStrong: Color.lerp(lineStrong, other.lineStrong, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      washStart: Color.lerp(washStart, other.washStart, t)!,
      washEnd: Color.lerp(washEnd, other.washEnd, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      glassStrong: Color.lerp(glassStrong, other.glassStrong, t)!,
      glassStroke: Color.lerp(glassStroke, other.glassStroke, t)!,
      glassEdge: Color.lerp(glassEdge, other.glassEdge, t)!,
      nightHi: Color.lerp(nightHi, other.nightHi, t)!,
      actionDisabled: Color.lerp(actionDisabled, other.actionDisabled, t)!,
      onActionDisabled: Color.lerp(
        onActionDisabled,
        other.onActionDisabled,
        t,
      )!,
      tintProduce: Color.lerp(tintProduce, other.tintProduce, t)!,
      tintGrain: Color.lerp(tintGrain, other.tintGrain, t)!,
      tintOil: Color.lerp(tintOil, other.tintOil, t)!,
      tintPackage: Color.lerp(tintPackage, other.tintPackage, t)!,
      tintProtein: Color.lerp(tintProtein, other.tintProtein, t)!,
      foodYam: Color.lerp(foodYam, other.foodYam, t)!,
      mapGround: Color.lerp(mapGround, other.mapGround, t)!,
      mapRoad: Color.lerp(mapRoad, other.mapRoad, t)!,
      mapBlock: Color.lerp(mapBlock, other.mapBlock, t)!,
      mapPin: Color.lerp(mapPin, other.mapPin, t)!,
      mapPinRing: Color.lerp(mapPinRing, other.mapPinRing, t)!,
      mapPinDot: Color.lerp(mapPinDot, other.mapPinDot, t)!,
      mapShadow: Color.lerp(mapShadow, other.mapShadow, t)!,
      actionHover: Color.lerp(actionHover, other.actionHover, t)!,
      actionPressed: Color.lerp(actionPressed, other.actionPressed, t)!,
    );
  }
}

/// Spacing scale (logical px).
abstract final class AppSpace {
  /// Icon-to-text gap inside chips.
  static const double s1 = 4;

  /// Gap between a title and its secondary line; chip padding.
  static const double s2 = 8;

  /// Gap between related controls; list row vertical padding.
  static const double s3 = 12;

  /// Screen side gutter, card padding, default stack gap.
  static const double s4 = 16;

  /// Padding of large cards and bottom sheets.
  static const double s5 = 20;

  /// Gap between sections on a screen.
  static const double s6 = 24;

  /// Top of screen to the first headline; gap before a primary action.
  static const double s8 = 32;

  /// Empty-state and success-screen breathing room.
  static const double s12 = 48;
}

/// Corner radii.
abstract final class AppRadius {
  /// Small things only: product thumbnails, tags and stepper buttons. Cards use radius-lg.
  static const double sm = 8;

  /// Inputs, OTP cells, chips, banners.
  static const double md = 16;

  /// Frosted cards, selection tiles, drop cards.
  static const double lg = 24;

  /// Overlapping frost sheets (top corners), colour-field folds, floating nav.
  static const double xl = 36;

  /// Progress tracks, segmented controls, avatar stacks.
  static const double pill = 999;
}

/// Sizes: touch targets, control heights, icons, glass blur.
abstract final class AppSize {
  /// Floor for any touch target (48dp). Equal to `tap-min`; kept as the name to reach for in rules. Fine-pointer web may go to `control-h-sm` (36), never on touch.
  static const double touchMin = 48;

  /// Preferred touch target (48dp). Steppers, chips that act, icon buttons. Same value as `touch-min`.
  static const double tapMin = 48;

  /// Height of buttons (md) and text inputs.
  static const double controlH = 52;

  /// White pill buttons on a night colour field.
  static const double controlHOnDark = 48;

  /// Raised centre Plan button in the bottom nav (night circle with a canvas ring).
  static const double planButton = 52;

  /// Height of the primary action at the bottom of a screen.
  static const double controlHLg = 60;

  /// Icons inside chips and secondary lines.
  static const double iconSm = 16;

  /// Default icons in buttons, lists and navigation.
  static const double iconMd = 24;

  /// Max content width when the Flutter app or the React web app runs on a wide screen; content is centred.
  static const double screenMax = 560;

  /// backdrop-filter blur for frost. Low-end Android: drop the blur and use `glass-strong` (see README, Glass).
  static const double blurGlass = 20;

  /// Compact control height for fine-pointer web (admin tables, toolbars). Never under touch; coarse pointers use `tap-min`.
  static const double controlHSm = 36;
}

/// Motion: durations and curves. Under Reduce Motion use reduced for everything.
abstract final class AppMotion {
  /// Press, toggle, select (buttons, chips, radios, stepper).
  static const durationPress = Duration(milliseconds: 140);

  /// Routine state change: collapse/expand, add to stepper, basket count, copied.
  static const durationState = Duration(milliseconds: 220);

  /// Sheets, push and container transform entering.
  static const durationSheetIn = Duration(milliseconds: 320);

  /// Sheets and push leaving. Always shorter than in.
  static const durationSheetOut = Duration(milliseconds: 250);

  /// Authored moments only: plan ready fold, handover check.
  static const durationMoment = Duration(milliseconds: 700);

  /// Under Reduce Motion every transition becomes this crossfade.
  static const durationReduced = Duration(milliseconds: 150);

  /// Press and routine state.
  static const easeOut = Curves.easeOut;

  /// Sheets, push, authored moments. No bounce or elastic.
  static const easeEmphasized = Cubic(0.16, 1, 0.3, 1);
}

/// Font families. Bundle the TTFs from design/system/fonts in pubspec.yaml under these family names.
abstract final class AppFonts {
  static const display = 'Bricolage Grotesque';
  static const sans = 'Plus Jakarta Sans';

  /// Money and counts use tabular figures.
  static const tabular = [FontFeature.tabularFigures()];
}

/// Text styles from the type scale. Colour comes from the theme; letter spacing converted from em.
abstract final class AppText {
  /// Hero money: plan total, savings balance. One per screen.
  static const displayXl = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 40,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
  );

  /// Onboarding and success headlines.
  static const displayLg = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 32,
    height: 1.0938,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.64,
  );

  /// Screen titles (Plus Jakarta Sans; Bricolage is for hero money and display headlines only).
  static const titleLg = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 24,
    height: 1.2917,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.24,
  );

  /// Section and card titles.
  static const titleMd = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  /// List-item titles, plan line names, button labels at size lg.
  static const titleSm = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 17,
    height: 1.2941,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  /// Lead paragraphs, important explanations.
  static const bodyLg = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
  );

  /// Default running text. Never set running text smaller than this.
  static const body = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 15,
    height: 1.4667,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
  );

  /// Secondary lines under a title, timestamps, helper text.
  static const bodySm = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 13,
    height: 1.3846,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
  );

  /// Buttons, tabs, segmented controls.
  static const label = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 15,
    height: 1.3333,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
  );

  /// Price-status chips, tags, badges. The smallest text the app uses.
  static const chip = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 12,
    height: 1.3333,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.12,
  );

  /// Line prices and subtotals. Always with tabular figures (font-feature `tnum`).
  static const money = TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: 17,
    height: 1.2941,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.0,
  );
}

/// Screen background gradients. Flame never fills a button, so there is no flame gradient.
abstract final class AppGradients {
  static LinearGradient night(AppColors c) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c.nightHi, c.night],
  );

  /// Screen background wash: static gradient, cheap on low-end Android.
  static LinearGradient wash(AppColors c) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c.washStart, c.canvas, c.washEnd],
    stops: const [0, .55, 1],
  );
}

extension AppThemeX on BuildContext {
  AppColors get tokens => Theme.of(this).extension<AppColors>()!;
}

/// Format integer kobo as Naira, e.g. 18450000 -> "₦184,500". Kobo shown only when non-zero.
String formatNaira(int kobo, {bool showKobo = false}) {
  final neg = kobo < 0;
  final abs = kobo.abs();
  final naira = abs ~/ 100;
  final k = abs % 100;
  final s = naira.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
  final tail = (showKobo || k != 0) ? '.${k.toString().padLeft(2, '0')}' : '';
  return '${neg ? '−' : ''}₦$s$tail';
}
