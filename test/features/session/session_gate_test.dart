import 'package:app_mobile/features/session/data/models/session_model.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final session = Session(
    accessToken: 'a',
    refreshToken: 'r',
    expiresAt: DateTime.utc(2030),
    gate: AuthGate.verifyEmail,
    email: 'ngozi@example.com',
  );

  test(
    'a gated session survives storage, so a restart resumes on the gate',
    () {
      final json = SessionModel.fromEntity(session).toJson();
      final back = SessionModel.fromJson(json).toEntity();
      expect(back, session);
      expect(back.gate, AuthGate.verifyEmail);
      expect(back.email, 'ngozi@example.com');
    },
  );

  test('sessions stored before gates existed read as clear', () {
    final old = SessionModel.fromJson({
      'accessToken': 'a',
      'refreshToken': 'r',
      'expiresAt': '2030-01-01T00:00:00.000Z',
    }).toEntity();
    expect(old.gate, AuthGate.none);
    expect(old.email, isNull);
  });

  test('a gate this build does not know reads as clear, not as a crash', () {
    final m = SessionModel.fromJson({
      'accessToken': 'a',
      'refreshToken': 'r',
      'expiresAt': '2030-01-01T00:00:00.000Z',
      'gate': 'someFutureGate',
    });
    expect(m.gate, AuthGate.none);
  });
}
