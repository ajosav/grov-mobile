import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_provider.dart';

part 'account_lookup.freezed.dart';

/// Whether an email already has an account, and how it signs in.
@freezed
abstract class AccountLookup with _$AccountLookup {
  const factory AccountLookup({
    required bool exists,
    required bool hasPassword,
    @Default(<AuthProvider>{}) Set<AuthProvider> providers,
  }) = _AccountLookup;
}
