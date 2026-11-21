# Performance

Budgets (arm64 release, images from network excluded): under 20 MB download, Welcome interactive under 2 s on a 2 GB phone, lists smooth with blur off. Check with `flutter build apk --release --split-per-abi --analyze-size` and profile mode on a low-end device before claiming a result.

## Startup

- Before `runApp`: synchronous, cheap work only. DI is lazy. No awaiting SQLite, secure storage, network, fonts or device info.
- After the first frame (`bootstrap.dart`): restore session, start settings, start sync status.
- The first screen (Splash/Welcome) uses flat token fills: no blur, no theme animation.

## Rendering

- `const` constructors wherever possible. No work, allocation of controllers, or sorting in `build`.
- Lists: `ListView.builder`/`SliverList.builder`; each row watches only its slice. Stable `ValueKey`s for reorderable/changing rows.
- Extract widgets (classes), not helper methods returning widgets, so rebuild boundaries are real.
- `RepaintBoundary` around expensive independent subtrees (map, animated hero), not everywhere.
- One map mounted at a time; dispose `MapController` and position stream with the route.
- Only the visible tab is mounted. Do not switch to an `IndexedStack`/keep-alive for tabs.
- Images: network images sized to display (`cacheWidth`), placeholders, image cache capped via `AppPerformance.imageCacheBytes`.
- Blur/`BackdropFilter`: expensive. Gate on `AppPerformance.allowsBlur`, max 3 per screen, never animate blur.
- Animations use transforms/opacity. No `setState` in animation ticks; use `AnimatedBuilder`/implicit widgets.
- Heavy JSON (> ~100 KB) decodes with `compute`.

## Low-end mode

`DeviceSettingsState.effectiveLowEnd` (Android low-RAM bit or user override) turns off blur and theme animation and tightens the image cache. New features must respect `AppPerformance`, not read device info themselves.

## Dependencies

Every dependency has to earn its place (size, startup, memory). Ask before adding one. Prefer the platform/Flutter solution. Import single libraries, not barrel files that pull a whole package. Record additions in `DECISIONS.md`.

## Release

R8 and resource shrinking are on. Icons tree-shaken. Fonts: ship only used weights (subset to Latin, Latin Extended, digits, punctuation, ₦) — not yet done, see `DECISIONS.md` M-014.
