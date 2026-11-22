import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_ticket.freezed.dart';

/// Proof that an email's code was right but it has no account yet. The profile
/// call spends it once; it stops working at [expiresAt].
@freezed
abstract class RegistrationTicket with _$RegistrationTicket {
  const factory RegistrationTicket({
    required String ticket,
    required DateTime expiresAt,
  }) = _RegistrationTicket;
}
