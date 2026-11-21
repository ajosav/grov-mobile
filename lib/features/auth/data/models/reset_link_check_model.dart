import 'package:json_annotation/json_annotation.dart';

part 'reset_link_check_model.g.dart';

/// API `ResetLinkCheck`.
@JsonSerializable(createToJson: false)
class const ResetLinkCheckModel({required final bool valid}) {
  factory ResetLinkCheckModel.fromJson(Map<String, dynamic> json) =>
      _$ResetLinkCheckModelFromJson(json);
}
