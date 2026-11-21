/// The product name is configuration, never a literal.
///
/// It is not decided yet and can change at any time, so nothing in the code,
/// persisted data or identifiers may depend on it. This is the only place in
/// `lib/` that spells it out, as the build-time default.
///
/// Override per build: `--dart-define=BRAND_NAME=...`.
///
/// Rules:
/// - Display copy: read [name]. In ARB, use a `{brand}` placeholder and pass
///   [name]; never type the name in a string.
/// - Persisted names (database file, secure-storage keys, Drift tables, cache
///   keys) are neutral and permanent. Never derive them from [name]:
///   changing them would drop users' data and sessions.
/// - Native display names (Android `strings.xml`, iOS `Brand.xcconfig`) and the
///   store identity (application ID / bundle ID, pubspec `name`) are set per
///   release. See ARCHITECTURE.md, "Renaming the product".
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract final class BrandConfig {
  static const name = String.fromEnvironment(
    'BRAND_NAME',
    defaultValue: 'Grov',
  );
}
