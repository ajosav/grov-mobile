# Presentation (Cubit / Bloc, pages)

Presentation depends on domain only. A Cubit/Bloc receives **use cases** through its constructor (never a repository, model, data source, Dio, Retrofit or Drift).

- **Cubit** for simple state changes driven by method calls. **Bloc** when events need transformers (search, submit, streams).
- State is a freezed type. Prefer a sealed union for screen status (`loading | data | failure`); use a single class with `copyWith` when many independent fields change. Never expose mutable collections.
- A Cubit/Bloc never holds `BuildContext`, never calls `GoRouter`, never shows a snackbar. For one-shot effects (navigate, toast) put a nullable `effect` in state that the page consumes in `BlocListener` and then acknowledges with a method call.
- It calls use cases and folds the `Result` into state with `switch`. Never throw out of a handler. Never swallow a `Failure`; map it to state the page can show.
- Streams: `emit.forEach` in Blocs, or a stored `StreamSubscription` in Cubits cancelled in `close()`. Stream use cases emit `Result` in-band; a failed event keeps the last good state.
- Constructor style: `required this._useCase` (private named parameters); fields named exactly like the parameter.

## Event transformers (`core/bloc/transformers.dart`)

| Situation | Use |
| --- | --- |
| Text that triggers work as the user types | `debounceRestartable()` |
| Submit / pay / save buttons | `dropWhileBusy()` |
| Load or refresh (latest wins) | `latestOnly()` |
| Writes that must not interleave | `inOrder()` |

A bare `on<E>(handler)` (concurrent) needs a comment saying why concurrency is safe.

## Pages

- One page per screen, `*_page.dart`. Pages read state and send intents; no business rules, no I/O.
- `BlocBuilder` with `buildWhen`, or `BlocSelector`, so a widget rebuilds only for the slice it draws.
- `context.read` in callbacks; `context.watch` only inside `build` when a selector isn't practical.
- Side effects go in `BlocListener` (`listenWhen` narrow), never in `builder`.
- App-lifetime Cubits (session, device settings, sync status) are provided once in `app.dart`; do not create a second instance.
- Screen Cubits are created by a `BlocProvider` in the route (factory from `getIt`), and closed by it. Do not `getIt<>()` inside a widget `build`.

## Resume

Backgrounding is not dispose. A Cubit keeps its state when the app is hidden. Flows that must survive process death write a draft through `DraftsDao` (via a use case) on hide (route, step, non-secret fields) and restore on start. No page `build` calls the network. Load order: memory, then draft, then network, and only on a first open when both are empty.
