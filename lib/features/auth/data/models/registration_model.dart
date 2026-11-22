import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/registration_ticket.dart';

part 'registration_model.g.dart';

/// The `registration` object of API `CodeVerifyResponse`.
@JsonSerializable(createToJson: false)
class const RegistrationModel({
  required final String ticket,
  required final DateTime expiresAt,
}) {
  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);

  RegistrationTicket toEntity() =>
      RegistrationTicket(ticket: ticket, expiresAt: expiresAt);
}
