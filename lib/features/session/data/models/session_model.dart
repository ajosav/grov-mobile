import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auth_gate.dart';
import '../../domain/entities/session.dart';

part 'session_model.g.dart';

/// API `TokenPair`: `{ accessToken, refreshToken, expiresAt }`. `gate` and
/// `email` are local-only extras: absent in API responses, kept in secure
/// storage so a gated session resumes on the right screen.
@JsonSerializable()
class const SessionModel({
  required final String accessToken,
  required final String refreshToken,
  required final DateTime expiresAt,
  @JsonKey(defaultValue: AuthGate.none, unknownEnumValue: AuthGate.none)
  final AuthGate gate = AuthGate.none,
  final String? email,
}) {
  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  factory SessionModel.fromEntity(Session s) => SessionModel(
    accessToken: s.accessToken,
    refreshToken: s.refreshToken,
    expiresAt: s.expiresAt,
    gate: s.gate,
    email: s.email,
  );

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);

  Session toEntity() => Session(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresAt: expiresAt,
    gate: gate,
    email: email,
  );
}
