---
name: mobile
description: Rules and templates for this Flutter app (Clean Architecture). Use before creating or changing a feature, entity, use case, repository, Retrofit API, model/DTO, Drift table/DAO/migration, Cubit/Bloc or its state, page, route, DI registration, shared widget, adaptive/responsive layout, fold/hinge handling, theme or token use, l10n string, anything that shows the product name, constructors or class declarations (Dart primary constructors), a Flutter/Dart/Xcode bump or release prep (platform deadlines), offline/sync/draft behaviour, performance-sensitive code (lists, startup, blur, images), dependency, or tests; and when reviewing such changes. Not needed for edits that touch none of these.
---

# Mobile — structural changes

Load only the reference for the action you are taking. `test/architecture_test.dart` failures name the rule broken; the reference below explains it.

| You are about to… | Read |
| --- | --- |
| Add a feature (new screen, flow, capability) | `references/feature-slice.md` |
| Add or change an entity, a use case, or a repository interface | `references/domain.md` |
| Add or change a Retrofit API, model, data source, repository impl, `Failure` mapping | `references/data-layer.md` |
| Write or change a Cubit/Bloc, its state, events, or how a page talks to it | `references/presentation.md` |
| Add or change a Drift table, DAO, migration, cache, draft, "last synced"; anything that must work offline | `references/offline.md` |
| Build or change a page layout, tab, navigation chrome, fold/hinge or tablet behaviour; use tokens, glass, type; show the product name | `references/adaptive-ui.md` |
| Touch startup, lists, images, blur, animation, or add a dependency | `references/performance.md` |
| Write or change tests | `references/testing.md` |
| Learn of a store/OS/SDK/Dart change; bump Flutter, Dart or Xcode; prepare a release; write constructors (Dart primary constructors) | `references/platform-updates.md` |
| Add a route or redirect | `references/feature-slice.md` (Routing) |

## Always true (no need to open a reference)

- Dependencies point inward: `presentation -> domain <- data`. Presentation calls **use cases only**. Domain is pure Dart. `core` never imports `features` (except `core/di`, `core/router`). Run `flutter test test/architecture_test.dart` after any import change.
- Use cases and repositories never throw; they return `Result<T>` / `Stream<Result<T>>`. Cubits fold results into freezed state; pages switch on state.
- Constructors use Dart primary constructors: declare each field once in the header (`class const X(final T _t)`); never `this.x` plus a separate `final T x;`.
- Platform changes are tracked in `PLATFORM_UPDATES.md`; read it before a release or an SDK bump.
- Retrofit is the only HTTP surface and lives in `data/datasources`. API shapes come from the backend `openapi.json`.
- The product name is configuration: never type it; use `BrandConfig.name` or an ARB `{brand}` placeholder. Dart identifiers use the `App` prefix; persisted names are neutral.
- Money is integer kobo; copy is in `app_en.arb`; colours are `context.tokens`; imports are `material_ui`.
- After freezed/json/drift/retrofit edits run `dart run build_runner build --delete-conflicting-outputs`; after ARB edits run `flutter gen-l10n`.
- Finish with `flutter analyze` and `flutter test`, and look at the UI on an emulator at phone and tablet width.
