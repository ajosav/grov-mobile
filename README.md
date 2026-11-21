# Mobile app

Household food planning, budgeting and buying for Nigerian homes. Flutter, iOS and Android, offline-first. The product name is configuration (`BrandConfig`), not code.

Start with [ARCHITECTURE.md](ARCHITECTURE.md); agent rules are in [AGENTS.md](AGENTS.md).

```
flutter pub get && dart run build_runner build --delete-conflicting-outputs && flutter gen-l10n
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000   # Android emulator -> host (live API)
flutter run --dart-define=API_BASE_URL=http://localhost:3000  # iOS simulator -> host
flutter test
```

Sign-on always talks to the live API. `API_BASE_URL` defaults to `http://localhost:3000`; on an Android emulator use `http://10.0.2.2:3000` as above.
