# Mobile architecture

Flutter, iOS and Android. Offline-first, adaptive to every device (D40), built for a 2 GB Android phone on 3G.
Agent rules live in `AGENTS.md`, decisions in `DECISIONS.md`, platform deadlines in `PLATFORM_UPDATES.md`, procedures in `.agents/skills/mobile`.
Product source of truth: `/Users/Adebayojoshua/sites/Grov/requirements` (PRODUCT.md, DESIGN.md, `design/docs`).

## Clean Architecture

```
presentation  ->  domain  <-  data
(Cubit/Bloc,      (entities,    (models, Retrofit APIs, Drift,
 pages)            use cases,    repository impls)
                   repository
                   interfaces)
```

Flow: `Page -> Cubit/Bloc -> UseCase -> Repository (interface) <- RepositoryImpl -> DataSource -> Drift DAO | Retrofit API`.

| Layer | Folder | Contains | Must not import |
|---|---|---|---|
| **Domain** | `features/<f>/domain` | `entities/` (freezed), `repositories/` (interfaces), `usecases/` (one class per file). Pure Dart. | Flutter, Drift, Dio, Retrofit, json_annotation, data, presentation |
| **Data** | `features/<f>/data` | `models/` (json_serializable), `datasources/` (Retrofit `*_api.dart`, local sources), `mappers/`, `repositories/` (impls) | presentation, Flutter UI |
| **Presentation** | `features/<f>/presentation` | `cubit/` or `bloc/` + freezed state, `pages/` (`*_page.dart`), `widgets/` | data, **repositories**, Drift, Dio, Retrofit |

`test/architecture_test.dart` enforces these, plus: use cases are one class per file implementing `UseCase`; repository impls implement a domain interface and live in `data/repositories`; only `data` uses Retrofit; the product name appears nowhere but `BrandConfig`; no raw colour literals.

Use cases return `Result<T>` (or `Stream<Result<T>>`) and never throw. Repositories wrap local calls in `guardLocal`/`guardStream` and network calls in `guardApi`. Cubits fold the result into freezed state.

## Stack

flutter_bloc + bloc_concurrency + stream_transform (state) · go_router · get_it (manual DI, `core/di/injection.dart`) · freezed + json_serializable + build_runner · dio + retrofit · drift · connectivity_plus · flutter_secure_storage.
Imports come from `package:material_ui/material_ui.dart` (Flutter 3.50 deprecated `flutter/material.dart`).

## Layout

```
lib/
  main.dart, bootstrap.dart, app.dart
  core/  config/ theme/ layout/ widgets/ database/ network/ connectivity/ error/ domain/ platform/ usecase/ bloc/ di/ router/
  features/<feature>/{domain,data,presentation}
  l10n/  app_en.arb (all copy; no English literals in widgets)
tool/sync_tokens.sh   regenerates core/theme/app_tokens.dart from the design source
```
`core` never imports `features`, except the composition root (`core/di`, `core/router`).

## Network (Retrofit on Dio)

- `core/network/api_client.dart` builds the app `Dio` (interceptors: auth, single-flight refresh, failure mapping, debug log) and `buildBareDio()` for calls that must not recurse (refresh).
- A feature declares its endpoints as a Retrofit `@RestApi()` class in `data/datasources/<name>_api.dart`, returning `ApiResponse<Model>` (`core/network/api_response.dart`). A thin data source unwraps `.data`. Models come from `grov-be/openapi/openapi.json`.
- `FailureInterceptor` turns error envelopes into `Failure` (by `code`, not `message`). `guardApi` returns them as `Err`.

## Rules

- **Money** is integer kobo (`core/domain/money.dart`). **Times** are WAT. **Colours** come from `context.tokens`. **Copy** is in `app_en.arb`.
- **DI:** repositories bind to interfaces; presentation gets use cases. App-lifetime Cubits (session, settings, sync) are lazy singletons; screen Cubits are factories from a `BlocProvider` in the route.
- **Bloc events** use `core/bloc/transformers.dart`.
- **Offline:** Drift is the copy of record. Repositories read Drift first, refresh from the network, write back via `CacheDao` (drives "last synced"). Checkout and Add money are network-only: disable with a reason, never hide.
- **Resume:** flows persist drafts through `DraftsDao` (never passwords, OTPs, identity tokens or card data).
- **Adding a feature:** copy the shape of `features/session` (domain, Retrofit API, models, datasources, repository impl, use cases, Cubit) or `features/settings` (Drift-backed), register it in `injection.dart`, add routes in `app_router.dart`.

## Performance

- First frame waits on nothing: DI is lazy, Drift opens lazily on a background isolate (WAL), session/settings/sync start after the first frame. The splash is a flat fill.
- Only the visible tab is mounted (`navigatorContainerBuilder` in `app_router.dart`).
- Pages select the slice they draw (`BlocSelector`/`buildWhen`). Lists use `ListView.builder`.
- Blur only when `AppPerformance.allowsBlur` (not low-end, not high contrast), max 3 surfaces per screen. Low-end mode (auto from Android low-RAM, user override) also zeroes theme animation and caps the image cache.
- Two bundled variable fonts, no `google_fonts`. R8 and resource shrinking on for Android release.
- Budgets (arm64 release): under 20 MB download, first screen interactive under 2 s on a 2 GB phone. Check with `flutter build apk --release --split-per-abi --analyze-size`.

## Every device (D40)

`AppWindow` classes: compact < 600 (bottom bar), medium 600-839 (rail), expanded >= 840 (rail + `TwoPane`). The window can resize live (iPhone Duo and Android folds), so layout derives from size only: never orientation, device model or hardcoded sizes. Where the OS reports a hinge (`MediaQuery.displayFeatures`, today Android), a hinge always splits and a fold splits only when not flat; the seam is empty padding. Whether Flutter reports fold geometry on iOS is unverified (PLATFORM_UPDATES IOS-005), so on iPhone Duo we rely on size alone. Content is capped (`ContentFrame`, 560 / 480 forms); type never scales with width. Tested at 360, 700, 1024 and 200% text.

## Renaming the product

The name is not decided; nothing depends on it. When it is decided, the change list is:

1. **Display name in Dart:** build with `--dart-define=BRAND_NAME=<name>` (or change the default in `lib/core/config/brand_config.dart`, the only place it appears).
2. **Launcher name:** `android/app/src/main/res/values/strings.xml` (`app_name`) and `ios/Flutter/Brand.xcconfig` (`APP_DISPLAY_NAME`).
3. **Store identity, once, before the first upload:** Android `namespace`/`applicationId` in `android/app/build.gradle.kts` and the Kotlin package folder; iOS `PRODUCT_BUNDLE_IDENTIFIER` in `ios/Runner.xcodeproj/project.pbxproj`. Currently the placeholder `com.grov.mobile` (DECISIONS M-021).
4. **Optional:** pubspec `name` (`app_mobile`, neutral already) and the repo/folder name.

Never rename persisted names (`app.sqlite`, `app.session.v1`, table and cache keys): that would drop users' data and sessions.

## Commands

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed, json, drift, retrofit
flutter gen-l10n
flutter analyze && flutter test
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000 --dart-define=BRAND_NAME=<name>
tool/sync_tokens.sh <path to design/flutter/*_tokens.dart>     # after the design tokens change
```
