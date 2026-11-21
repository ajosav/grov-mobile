import 'package:flutter/foundation.dart';

/// Debug-build switches. None of this exists in a release build: every use is
/// behind `kDebugMode`, a compile-time constant, so it is tree-shaken away.
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract final class DebugConfig {
  /// Answer sign-on from built-in sample data instead of the API, so every
  /// screen can be reached with no backend running.
  ///
  /// On by default in a debug build that was not given an `API_BASE_URL`
  /// (nothing to talk to). Passing `--dart-define=API_BASE_URL=...` starts it
  /// off. The panel on Welcome flips it at run time.
  static final sampleData = ValueNotifier<bool>(
    kDebugMode && const String.fromEnvironment('API_BASE_URL').isEmpty,
  );
}
