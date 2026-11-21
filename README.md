# Mobile app

Household food planning, budgeting and buying for Nigerian homes. Flutter, iOS and Android, offline-first. The product name is configuration (`BrandConfig`), not code.

Start with [ARCHITECTURE.md](ARCHITECTURE.md); agent rules are in [AGENTS.md](AGENTS.md).

```
flutter pub get && dart run build_runner build --delete-conflicting-outputs && flutter gen-l10n
flutter run                                                   # debug: sign-on runs on sample data, no backend needed
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000   # Android emulator -> host (live API)
flutter test
```

Debug builds show a **Debug** chip on Welcome: it switches between sample data and the live API and lists what to type to reach each screen (for example `known@x.com` logs in, `new@x.com` joins, code `123456` is accepted). Release builds do not contain any of it.
