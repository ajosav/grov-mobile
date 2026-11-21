import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/session_model.dart';

/// Keychain (iOS) / Keystore-backed storage (Android).
class SessionLocalDataSource([FlutterSecureStorage? storage]) {
  this : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'app.session.v1';
  final FlutterSecureStorage _storage;

  Future<SessionModel?> read() async {
    try {
      final raw = await _storage.read(key: _key);
      if (raw == null) {
        return null;
      }
      return SessionModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      // Corrupt or unreadable (e.g. restored backup): treat as signed out.
      await _storage.delete(key: _key);
      return null;
    }
  }

  Future<void> write(SessionModel model) =>
      _storage.write(key: _key, value: jsonEncode(model.toJson()));

  Future<void> delete() => _storage.delete(key: _key);
}
