# Adaptive UI and design system

Source of truth: `requirements/DESIGN.md`, `design/system/tokens.json`, the design Figma file. Every device (D40): iPhone, iPad, Duo, Android phones, tablets, folds. Do not ship a stretched 390 layout.

## Window classes (`core/layout/app_window.dart`)

| Class | Width | Layout |
| --- | --- | --- |
| compact | < 600 | one column, bottom `NavigationBar` |
| medium | 600–839 | fold inner (Android folds, iPhone Duo), small tablet: `NavigationRail`, two panes when `canShowTwoPanes` |
| expanded | ≥ 840 | rail + list/detail (`TwoPane`) |

- Read it with `AppWindow.of(context)`. It uses `MediaQuery.sizeOf`/`displayFeaturesOf`, so a widget rebuilds only for size/feature changes.
- Where the OS reports a hinge (Android: Surface Duo, Pixel Fold), it always separates; a fold separates only when not flat (Galaxy Fold half-open). The seam is empty: nothing draws or taps on `hinge` bounds. `TwoPane` handles it.
- Extra width becomes columns or list-detail. Content is capped: `ContentFrame` (560 content, 480 forms). Type does not grow with width.
- Test at 360, 390, 600+, 1024, and 200% text scale. A fold must not lose state when it folds/unfolds (Cubits hold state, not widgets).

## iPhone Duo (Apple's foldable) and live resizing

Apple: apps built with the iOS 27 SDK resize dynamically on iPhone Duo; hardcoded sizes, fixed orientations and device assumptions break layouts; the 27.1 SDK optimises further. So:

- Derive layout from `MediaQuery.sizeOf`/`AppWindow` only. Never from orientation, device model, platform idiom, or a hardcoded pixel size.
- Keep orientations unlocked (`platform_compliance_test.dart` fails if locked).
- State lives in Cubits, not widgets: a fold or unfold must lose nothing (covered by the fold/unfold test).
- Do not assume Flutter reports fold geometry on iOS (unverified, PLATFORM_UPDATES IOS-005). Hinge-splitting is a progressive enhancement where the OS reports one.

## Layout rules

- Safe areas everywhere. 16px gutter on compact. Primary action sits at the bottom as a pill.
- 48dp tap targets (`AppSize.touchMin`). Body text ≥ 15, chips ≥ 12 bold. Reflow at 200% text: wrap or scroll, never clip. `itemExtent` only for rows whose height does not depend on text.
- Use `Flexible`/`Expanded`/`Wrap`; no fixed heights on text containers; no `Platform.isIOS` layout forks (adapt by window class; use platform only for conventions like back gestures).
- Tab roots use `AppShellView`; task flows are outside the shell so nav hides.

## Tokens and theme

- Colours: `context.tokens` (`AppColors`). No hex. Never raw `Colors.*` except `Colors.transparent`.
- Spacing/radius/size: `AppSpace`, `AppRadius`, `AppSize`. Type: `Theme.of(context).textTheme` (display = hero naira only; title 20/17; body 15).
- The One Orange rule: flame marks active/in-motion, never a primary-button fill; text on flame/palm/leaf is `onBright` (dark ink), never white. Green = Locked/Paid/Delivered only. Crimson = real failures only, never over-budget.
- Screen ground: wrap screens in `AppScreen` (static wash). Scaffold background is transparent inside it.
- Glass: `GlassCard`. Cards carry no blur. Overlays (sheets, menus, dialogs) use `glassStrong` and may blur. Max 3 blurred surfaces per screen; blur only if `AppPerformance.allowsBlur(context)`.
- Dark mode ships with light: same tokens, check both.
- Motion: tokens in `AppMotion` (140/220/320/700ms). No bounce, elastic or looping. Respect reduce-motion (`MediaQuery.disableAnimationsOf`). Low-end: no blur animation, sheets animate transform only.
- Accessibility: semantic labels on icon buttons and progress; reduced motion and transparency respected; WCAG 2.1 AA contrast.

## Product name

Never type it. Titles and display text read `BrandConfig.name`; copy that mentions the product uses a `{brand}` placeholder in `app_en.arb` and the page passes `BrandConfig.name`. Do not build wordmarks or logos into code: use assets, swappable per release.

## Copy

All text in `lib/l10n/app_en.arb`, read via `AppLocalizations.of(context)`. Whole strings (no concatenated fragments) so Pidgin, Yoruba, Igbo and Hausa can follow. Button labels start with a verb and name the result. Money: `formatNaira(kobo)`; dates DD/MM/YYYY WAT.
