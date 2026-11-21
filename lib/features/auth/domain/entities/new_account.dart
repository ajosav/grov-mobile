import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_account.freezed.dart';

/// The details a new account is created from. [phone] is normalised to
/// +234 form before it gets here.
@freezed
abstract class NewAccount with _$NewAccount {
  const factory NewAccount({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  }) = _NewAccount;
}
