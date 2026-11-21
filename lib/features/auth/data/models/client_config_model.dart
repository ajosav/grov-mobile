import 'package:json_annotation/json_annotation.dart';

import 'legal_versions_model.dart';

part 'client_config_model.g.dart';

@JsonSerializable(createToJson: false)
class const ClientConfigModel({required final LegalVersionsModel legal}) {
  factory ClientConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ClientConfigModelFromJson(json);

  String get termsVersion => legal.termsVersion;
}
