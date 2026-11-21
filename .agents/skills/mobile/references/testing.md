# Testing

`flutter analyze` clean and `flutter test` green before finishing. Name tests by behaviour; cite D-numbers or requirement ids where a product rule is under test.

| Layer | How |
| --- | --- |
| Architecture | `test/architecture_test.dart` (never weaken it). |
| Domain | Plain Dart tests: money, formatting, rules. Money tests include large values and negative values. |
| Drift/DAOs | `AppDatabase.inMemory()`, real SQLite, no mocks. Test migrations from the previous schema. Drift returns local `DateTime`s: compare with `isAtSameMomentAs`. |
| Use cases | Mock the repository interface; assert delegation and orchestration order. |
| Retrofit / data sources | Real Retrofit API over a stub `HttpClientAdapter` and the real `FailureInterceptor`: assert path, body, envelope parsing and failure mapping (`test/features/session/session_repository_test.dart`). |
| Repositories | Fake/mock data sources. Include a case where the source throws and the repository returns an `Err`. |
| Cubits/Blocs | `bloc_test` + `mocktail` mocking the **repository** (real use cases over a fake repository, see `test/helpers/cubit_factories.dart`). Assert state sequences, not internals. Use `StreamController.broadcast()` in fakes (single-subscription `close()` hangs). |
| Views | Widget tests with `pumpWidget` at 360×640, 700×800, 1024×768 and `textScaleFactor 2.0`; assert no overflow (`tester.takeException()`), the right nav (bar vs rail), and hinge behaviour with `tester.view.displayFeatures`. |
| Router | Redirect tests with a fake `SessionRepository`. |

- Fake the data boundary (repository interface), not the use cases, never Dio or Drift inside Cubit tests.
- No real network, no real secure storage, no sleeping: use fakes, `pump`, and `wait` in `blocTest`.
- A bug fix starts with a failing test.
- UI changes also get a real look on an emulator (phone and tablet width). Say so if it wasn't possible.
- Integration tests (`integration_test/`) need a device; if none is available, say "integration test not run: no device".
- Tests never type the product name: use `BrandConfig.name` or a fixture.
