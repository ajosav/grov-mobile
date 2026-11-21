# Adding a feature

Copy the shape of `features/session` (Retrofit + models + use cases) or `features/settings` (Drift-backed).

```
features/<feature>/
  domain/
    entities/<name>.dart                  freezed, pure Dart, no JSON
    repositories/<name>_repository.dart   abstract interface class, returns Result
    usecases/<verb>_<noun>.dart           one class per file
  data/
    models/<name>_model.dart              @JsonSerializable, toEntity()/fromEntity()
    datasources/<name>_api.dart           Retrofit @RestApi, returns ApiResponse<Model>
    datasources/<name>_remote_data_source.dart   unwraps ApiResponse.data
    datasources/<name>_local_data_source.dart    secure storage / DAO wrapper (if it adds logic)
    mappers/<name>_mapper.dart            Drift row -> entity
    repositories/<name>_repository_impl.dart     implements the interface
  presentation/
    cubit/<name>_state.dart               freezed
    cubit/<name>_cubit.dart               (or bloc/ with _bloc.dart + _event.dart)
    pages/<name>_page.dart                one per screen
    widgets/                              feature-only widgets
```

Steps:

1. Read the PRD/decision (D-number) for the feature. Money, units, copy and states come from there, not memory.
2. **Domain first:** entity, repository interface, use cases (`domain.md`). Pure Dart.
3. **Data:** models and the Retrofit API from `openapi.json`, data sources, repository impl; Drift table/DAO if cached offline (`offline.md`, `data-layer.md`).
4. **Presentation:** freezed state, Cubit/Bloc calling use cases (`presentation.md`).
5. **Page:** reads state, sends intents. Adaptive from the start (`adaptive-ui.md`). Strings in `app_en.arb`; the product name only via `{brand}`/`BrandConfig`.
6. **Register** in `core/di/injection.dart` (a `_feature()` function): API, data sources, repository against its interface, use cases, and the Cubit (factory for screen-scoped).
7. **Route** in `core/router/app_router.dart`, path constant in `routes.dart`. The route owns the `BlocProvider`: `BlocProvider(create: (_) => getIt<XCubit>()..load(), child: const XPage())`.
8. Tests (`testing.md`), build_runner, gen-l10n, analyze, test, look at it.

## Routing

- Paths are constants in `Routes`. No string literals in pages. Navigate with `context.go` (replace stack, tabs) or `context.push` (drill-in).
- Tab roots live in `StatefulShellRoute`; task flows (sign-on, checkout, cook order, address, account) are top-level routes so the nav hides.
- Redirects live in one function (`_redirect`) and depend only on `SessionState`. D37: no session means Welcome; unverified email means verify; nothing is reachable as a guest.
- Pass ids through the path, not objects. A route must be restorable from its URL.
