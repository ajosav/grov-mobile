import 'package:json_annotation/json_annotation.dart';

part 'legal_versions_model.g.dart';

@JsonSerializable(createToJson: false)
class const LegalVersionsModel({
  required final String termsVersion,
  required final String privacyVersion,
}) {
  factory LegalVersionsModel.fromJson(Map<String, dynamic> json) =>
      _$LegalVersionsModelFromJson(json);
}
