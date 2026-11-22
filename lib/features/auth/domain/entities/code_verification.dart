import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_outcome.dart';
import 'registration_ticket.dart';

part 'code_verification.freezed.dart';

/// What a correct email code leads to.
@freezed
sealed class CodeVerification with _$CodeVerification {
  /// The address has an account: the outcome carries the session.
  const factory CodeVerification.signedIn(AuthOutcome outcome) = CodeSignedIn;

  /// No account yet: collect the profile with this ticket.
  const factory CodeVerification.profileRequired(RegistrationTicket ticket) =
      CodeProfileRequired;
}
