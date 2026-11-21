# Platform updates and Dart language updates

`PLATFORM_UPDATES.md` (repo root) is the register of store, OS, SDK and language changes. Read it before a release and on every Flutter, Dart or Xcode bump.

## Capturing an update

1. Add a row immediately (ID, change, effective date as the source states it, status, evidence). Statuses: Done, Action, Watch, N/A.
2. Evidence is a **primary** page (Apple, Google, Flutter, Dart). A blog, forum guess or AI summary is `UNVERIFIED (secondary: ...)` and cannot be marked Done. Do not invent a deadline day.
3. If it can be checked from files, add a test to `test/platform_compliance_test.dart`.
4. If it changes a rule agents must follow, update `AGENTS.md` and add a `DECISIONS.md` row (Pending until the user rules).
5. Bump "Last reviewed".

## Known upcoming (see the register for status)

- iOS 27 SDK (Xcode 27) required for App Store uploads from April 2027; iOS 15 minimum target.
- UIScene lifecycle mandatory with the iOS 27 SDK (done; do not customise `AppDelegate` without re-reading the Flutter UIScene doc).
- iPhone Duo: live resize, no orientation or device assumptions; verify on the Xcode 27.1 iPhone Duo simulator.
- Privacy manifests and required-reason APIs for the app and SDKs.

## Dart primary constructors (Dart 3.13+)

Declare fields in the constructor header:

```dart
class const SignOut(final SessionRepository _repository) implements UseCase<void, NoParams> { ... }
class SessionCubit({required final RestoreSession _restoreSession, ...}) extends Cubit<SessionState> {
  this : super(const SessionState.unknown());
}
```

- Public call-site name for private named parameters: field `_restoreSession`, call `restoreSession:`.
- Initializer lists and assertions go in `this : ...` inside the body; extra constructors must redirect to the primary one (`new named() : this(...)`).
- Freezed classes keep `const factory` form. json_serializable and Retrofit work with primary constructors.
- Migration of old code: `dart fix --apply --code=use_primary_constructors`, then `python3 tool/declare_primary_params.py <files>` (merges `this.x` + `final T x;`), then `dart format`, build_runner, analyze, test. Review the diff.
- The lint flags classes that have no constructor (interfaces, static-only): do not add `()`; use `// ignore: use_primary_constructors (no constructor by design: interface/static-only)`.
- Skill with the full syntax reference: `dart-flutter:dart-use-primary-constructors`.
