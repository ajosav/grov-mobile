import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/config/brand_config.dart';
import '../../../../core/platform/uuid_v7.dart';

/// The `device` object the API wants on sign-up, log-in and reset: a stable
/// id made once and kept in secure storage, the platform, and a name.
class DeviceIdentityDataSource([
  FlutterSecureStorage? storage,
  DeviceInfoPlugin? info,
]) {
  this
    : _storage = storage ?? const FlutterSecureStorage(),
      _info = info ?? DeviceInfoPlugin();

  static const _key = 'app.device.id';
  final FlutterSecureStorage _storage;
  final DeviceInfoPlugin _info;

  Future<Map<String, Object?>> read() async => {
    'id': await _id(),
    'platform': Platform.isIOS ? 'IOS' : 'ANDROID',
    'name': await _name(),
  };

  Future<String> _id() async {
    try {
      final stored = await _storage.read(key: _key);
      if (stored != null) {
        return stored;
      }
    } on Object {
      // Fall through and make a new one; an unreadable store must not block
      // sign-on.
    }
    final fresh = uuidV7();
    try {
      await _storage.write(key: _key, value: fresh);
    } on Object {
      // Kept for this call only.
    }
    return fresh;
  }

  /// Model only: the user-set device name can contain their own name.
  Future<String> _name() async {
    try {
      final model = Platform.isIOS
          ? (await _info.iosInfo).model
          : (await _info.androidInfo).model;
      return _clip('$model · ${BrandConfig.name}');
    } on Object {
      return _clip(BrandConfig.name);
    }
  }

  String _clip(String s) => s.length <= 80 ? s : s.substring(0, 80);
}
