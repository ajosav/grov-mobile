import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/account_lookup.dart';
import '../../domain/entities/auth_provider.dart';

part 'lookup_response_model.g.dart';

/// API `LookupResponse`: `state` is `NEW` or `EXISTS`.
@JsonSerializable(createToJson: false)
class const LookupResponseModel({
  required final String state,
  required final bool hasPassword,
  final List<String> providers = const [],
}) {
  factory LookupResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LookupResponseModelFromJson(json);

  AccountLookup toEntity() => AccountLookup(
    exists: state == 'EXISTS',
    hasPassword: hasPassword,
    providers: {
      for (final p in providers)
        switch (p) {
          'GOOGLE' => AuthProvider.google,
          'APPLE' => AuthProvider.apple,
          _ => null,
        },
    }.nonNulls.toSet(),
  );
}
