// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_check_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordCheckModel _$PasswordCheckModelFromJson(Map<String, dynamic> json) =>
    PasswordCheckModel(
      ok: json['ok'] as bool,
      problems:
          (json['problems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
