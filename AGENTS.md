# AGENTS.md — mobile app

Flutter (iOS + Android), offline-first, adaptive to every device: iPhone, iPad, **iPhone Duo** (Apple's foldable), Android phones and tablets, and Android folds (Galaxy Fold, Pixel Fold, Surface Duo). Target hardware: a 2 GB Android phone on 3G. Speed, responsiveness and offline support are not negotiable.

## Precedence

1. The user's latest instruction in chat.
2. `DECISIONS.md` (append-only record of what the user decided; Approved rows are fact, Pending rows are proposals).
3. This file.
4. Product source of truth: `/Users/Adebayojoshua/sites/Grov/requirements` (`PRODUCT.md`, `DESIGN.md`, `CLAUDE.md`, `design/docs/00-context-and-decisions.md` decision log D1–D40 wins over older docs). Backend contract: `/Users/Adebayojoshua/sites/Grov/grov-be/openapi/openapi.json`.
5. `ARCHITECTURE.md` (how the code is organised).
6. `PLATFORM_UPDATES.md` (store, OS, SDK and language changes with deadlines and status; see the next section).

If a fact is missing or two sources disagree, stop and ask in chat. Do not build from memory or guess a product rule. Record the answer in `DECISIONS.md`.

## Platform updates are tracked, not remembered

Apple, Google, Flutter and Dart change requirements on their own schedule (for example: iOS 27 SDK and iOS 15 minimum for App Store uploads from April 2027, mandatory UIScene, iPhone Duo, Dart primary constructors). `PLATFORM_UPDATES.md` is the register.

- Before a release, and on every Flutter, Dart or Xcode bump, read it and update "Last reviewed".
- When you learn of a platform change, add a row at once. Evidence is a primary source (Apple, Google, Flutter, Dart pages) or the row says `UNVERIFIED (secondary)`; never mark `Done` on a blog post.
- A requirement we can check from files gets a test in `test/platform_compliance_test.dart`.
- Never invent a deadline day. Record what the source says.

## Product name is configuration, never a literal

The product name is not decided and can change at any time. Nothing may depend on it.

- Never type the name in Dart, ARB, tests, identifiers, filenames, persisted names or log text. Read `BrandConfig.name` (`lib/core/config/brand_config.dart`, the only file that spells it, as a build-time default overridable with `--dart-define=BRAND_NAME=...`). In ARB, use a `{brand}` placeholder and pass `BrandConfig.name`.
- Dart identifiers use the neutral `App` prefix (`AppTheme`, `AppColors`, `AppWindow`, `context.tokens`). Never prefix with a product name.
- Persisted names are neutral and permanent: database file `app.sqlite`, secure-storage keys `app.*`, cache and draft keys. Never derive them from the brand: changing them drops users' data and sessions.
- Native display names live in one file each: `android/app/src/main/res/values/strings.xml` and `ios/Flutter/Brand.xcconfig`. Store identity (application ID / bundle ID, pubspec `name`) is set per release; see ARCHITECTURE.md "Renaming the product".
- Tests use `BrandConfig.name` or a fixture, never a literal. `test/architecture_test.dart` fails if the name appears anywhere else in `lib/` or `test/`.

## Structural changes → use the `mobile` skill

Before adding or changing a feature, entity, use case, repository, Retrofit API, model, Drift table or DAO, Cubit/Bloc, route, DI registration, shared widget, layout/adaptive behaviour, l10n string, dependency, or tests, load the skill and only the reference it points you to:

- Claude Code: skill `mobile` (`.claude/skills/mobile`)
- Other agents: read `.agents/skills/mobile/SKILL.md`

## Stack (locked)

Flutter, Dart. `flutter_bloc`, `bloc_concurrency`, `stream_transform` (state) · `go_router` (routing) · `get_it` (manual DI, no codegen) · `freezed` + `freezed_annotation`, `json_serializable` + `json_annotation`, `build_runner` · `dio` + `retrofit` + `retrofit_generator` (typed API clients) · `drift` + `drift_flutter` + `drift_dev` (offline DB) · `connectivity_plus`, `flutter_secure_storage`, `device_info_plus`, `path_provider`, `path`, `intl` · tests: `flutter_test`, `bloc_test`, `mocktail`.

Never add a dependency without asking. Never use Riverpod, Provider, GetX, MobX, injectable, auto_route, Hive, sqflite, shared_preferences for app data, `google_fonts`, hand-written Dio calls in data sources (use a Retrofit API), or any analytics/crash SDK unless `DECISIONS.md` approves it. Imports come from `package:material_ui/material_ui.dart`, never `package:flutter/material.dart` (deprecated in Flutter 3.50).

## Architecture: Clean Architecture (enforced by `test/architecture_test.dart`)

`Page -> Cubit/Bloc -> UseCase -> Repository (domain interface) <- RepositoryImpl -> DataSource -> Drift DAO | Retrofit API`

Dependencies point inward: `presentation -> domain <- data`. Domain knows nothing about the others.

- `features/<f>/domain`: **pure Dart.** `entities/` (freezed, no JSON), `repositories/` (abstract interfaces), `usecases/` (one class per file, implements `UseCase`/`StreamUseCase`). No Flutter, Drift, Dio, Retrofit, json_annotation, get_it.
- `features/<f>/data`: `models/` (`json_serializable`, `toEntity()`/`fromEntity()`), `datasources/` (Retrofit `*_api.dart`, local sources, thin remote/local wrappers), `mappers/` (Drift row -> entity), `repositories/` (`*_repository_impl.dart`). Never imports presentation. Only `data` imports Retrofit; only `data` and `core/database` import Drift.
- `features/<f>/presentation`: `cubit/` or `bloc/` (+ freezed state), `pages/` (`*_page.dart`, one per screen), `widgets/` (feature-only). **Calls use cases only**: never a repository, model, data source, Drift, Dio or Retrofit. No `BuildContext` in Cubit/Bloc; no navigation or snackbars from them (expose a one-shot state the page reacts to).
- Use cases do not throw: they return `Result<T>` (`Failure` on error) or `Stream<Result<T>>`. Repositories never throw to callers: local calls use `guardLocal`/`guardStream`, network calls use `guardApi`. Cubits fold `Result` into state. Widgets never see `Result`.
- `core` never imports `features`, except `core/di` and `core/router` (composition root).
- Screen-scoped Cubits/Blocs are factories created by a `BlocProvider` in the owning route. Only session, device settings and sync status are app-lifetime singletons.

## Always

- **Money is integer kobo.** Never `double`. Format with `core/domain/money.dart`. The server computes totals, prices and states; the app renders them. Budget never blocks checkout; overage is stated neutrally.
- **Every price carries a status** (Locked · Estimate · Updated X ago · Price changed · Out of stock).
- **Offline first.** Drift is the copy of record for catalogue, plan and household. Read Drift, refresh from the network, write back. Network-only actions (checkout, Add money) are disabled with a stated reason, never hidden. Offline is shown neutrally ("Offline · last synced 7:40am"), never as an error.
- **Never** write passwords, OTPs, identity tokens or card data to Drift. Auth tokens live only in secure storage.
- **API shapes come from the OpenAPI contract**, not memory. Retrofit methods return `ApiResponse<Model>`; the data source unwraps `.data`. Branch on the error `code`, never `message`.
- **Every device (D40).** Layout reads `AppWindow` (compact < 600, medium 600–839, expanded ≥ 840, hinge/fold aware where the OS reports a hinge). The window can resize live (iPhone Duo and Android folds): derive layout from size only, never from orientation, device model, idiom or hardcoded sizes; state lives in Cubits so a fold or unfold loses nothing. Extra width becomes columns or list-detail, never a stretched 390 frame. Check 360pt and 390pt, tablet, and 200% text scale. Tap targets 48dp. No fixed heights on text.
- **Performance.** Nothing before the first frame awaits SQLite, secure storage or the network. Lists are `ListView.builder`. Pages select the slice they draw (`BlocSelector`, `buildWhen`). Blur only through `AppPerformance.allowsBlur`, at most 3 surfaces per screen. Only the visible tab is mounted. No `setState` for shared state. No work in `build`.
- **Design.** Colours only via `context.tokens`; no hex literals in widgets. Type from `Theme.of(context).textTheme`. Orange is never a primary-button fill; text on orange/palm/leaf is dark ink. Follow `requirements/DESIGN.md`.
- **Copy** lives in `lib/l10n/app_en.arb`; no English literals in widgets. Plain sentence-case English. No emoji. No "wallet", "deposit", "bank", "returns", calories, or weight-loss claims.
- **Times** are WAT; units are g/kg/L plus natural counts (D33).
- **Bloc events** use `core/bloc/transformers.dart` (`debounceRestartable`, `dropWhileBusy`, `latestOnly`, `inOrder`). No bare `on<E>` for submit buttons, searches or loads.
- **Dart style: primary constructors (Dart 3.13+).** Declare fields once, in the constructor header: `class const SignOut(final SessionRepository _repository) implements ...`, `required final T _x` for private named parameters. Never write `this.x` plus a separate `final T x;` for a plain field. Freezed classes keep their `const factory` form. The `use_primary_constructors` lint is on; a class with deliberately no constructor (interface, static-only) carries `// ignore: use_primary_constructors (...)`. After `dart fix --apply --code=use_primary_constructors`, finish with `python3 tool/declare_primary_params.py <files>` and review the diff.
- One public class per file; relative imports inside `lib`; no `print`; no `!` on nullable without a comment explaining the invariant.
- No PII or secrets in logs, errors or crash output.

## Never

Edit generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/app_localizations*.dart`) by hand. Edit `lib/core/theme/app_tokens.dart` by hand (change the design source and run `tool/sync_tokens.sh`). Edit `test/architecture_test.dart`, `analysis_options.yaml` or CI to make a check pass (changing it because the user changed the architecture is fine; say so). Use `--no-verify`. Change `core/`, `bootstrap.dart` or `app.dart` unless the task needs it (say so when you do). Make drive-by refactors. Invent customers, prices, testimonials or sample data not in `design/system/sample-data.json`. Lock screen orientation. Silently change a product rule.

## Done means

`dart run build_runner build --delete-conflicting-outputs` (if you touched freezed/json/drift/retrofit), `flutter gen-l10n` (if you touched ARB), then `flutter analyze` (no issues) and `flutter test` (all pass), with the output reported. UI changes: run the app on an emulator and look at it at phone width and tablet width; say so if you could not. Commits: `type(scope): subject`.

## Keeping the rules alive

When the user makes a decision, append it to `DECISIONS.md` (only after they state it in chat). When a rule here proves wrong, propose the change in chat; do not edit this file to justify code you already wrote.
