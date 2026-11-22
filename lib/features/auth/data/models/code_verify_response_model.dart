import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/code_verification.dart';
import 'auth_response_model.dart';
import 'registration_model.dart';

part 'code_verify_response_model.g.dart';

/// API `CodeVerifyResponse`: `SIGNED_IN` carries `auth`, `PROFILE_REQUIRED`
/// carries `registration`.
@JsonSerializable(createToJson: false)
class const CodeVerifyResponseModel({
  required final String state,
  final AuthResponseModel? auth,
  final RegistrationModel? registration,
}) {
  factory CodeVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CodeVerifyResponseModelFromJson(json);

  CodeVerification toEntity() {
    final ticket = registration;
    if (state == 'PROFILE_REQUIRED' && ticket != null) {
      return CodeVerification.profileRequired(ticket.toEntity());
    }
    // A state this build does not know, or a missing body, opens nothing.
    return CodeVerification.signedIn(auth?.toEntity() ?? const AuthOutcome());
  }
}
