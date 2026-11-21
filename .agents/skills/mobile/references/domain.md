# Domain (entities, use cases, repository contracts)

Pure Dart. No Flutter, Drift, Dio, Retrofit, json_annotation or get_it. `test/architecture_test.dart` fails otherwise.

## Entities

- `@freezed abstract class X with _$X`, immutable, `const factory`. No `fromJson`/`toJson` (that is a data-layer model's job).
- Money fields are `int` kobo. Quantities and units follow D33. Never `double` for money.
- Business rules that do not need I/O live on the entity (or a small pure function beside it), not in a Cubit and not in a widget.

## Repository interface

- `abstract interface class XRepository` in `domain/repositories`.
- Methods return `Future<Result<T>>` or `Stream<Result<T>>`. Never a model, a Drift row, `Dio`, or a raw exception.
- Name methods for the business (`restore`, `refresh`, `watchLastSyncedAt`), not the transport (`get`, `post`).

## Use cases

- One class per file in `domain/usecases`, named verb + noun (`RestoreSession`, `WatchOnline`), implementing `UseCase<Output, Params>` or `StreamUseCase<Output, Params>` (`core/usecase/usecase.dart`).
- `const` constructor taking the repository; `call(params)` delegates and may orchestrate several repositories or steps (token rotation, cache-then-refresh, biometric then pay).
- Params: the entity, a small freezed params class, or `NoParams`.
- A use case that only forwards one repository call is still a use case: presentation must not reach a repository directly. Keep it a single line.
- Never throws; never touches `BuildContext`, widgets, Drift or Dio.

## Failures

`core/error/failure.dart` sealed `Failure` and `Result<T>`. Return `Result.err(...)`; do not invent new exception types.
