import 'package:json_annotation/json_annotation.dart';

part 'forgot_accepted_model.g.dart';

/// API `ForgotPasswordAccepted`.
@JsonSerializable(createToJson: false)
class const ForgotAcceptedModel({required final DateTime nextSendAt}) {
  factory ForgotAcceptedModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotAcceptedModelFromJson(json);
}
