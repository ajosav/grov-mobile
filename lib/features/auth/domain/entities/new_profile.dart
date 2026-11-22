import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_profile.freezed.dart';

/// Who a new person is, sent with the [RegistrationTicket] to create the
/// account. The email is already verified by the code, so it is not here.
@freezed
abstract class NewProfile with _$NewProfile {
  const factory NewProfile({
    required String ticket,
    required String firstName,
    required String lastName,
    required String phone,
    required String termsVersion,
  }) = _NewProfile;
}
