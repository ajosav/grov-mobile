import 'package:app_mobile/features/auth/data/models/auth_response_model.dart';
import 'package:app_mobile/features/auth/data/models/lookup_response_model.dart';
import 'package:app_mobile/features/auth/data/models/password_check_model.dart';
import 'package:app_mobile/features/auth/domain/entities/auth_provider.dart';
import 'package:app_mobile/features/auth/domain/entities/password_problem.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _auth(String step, {bool tokens = true}) => {
  'nextStep': step,
  'user': {
    'id': '0192',
    'firstName': 'Ngozi',
    'email': 'ngozi@example.com',
    'emailVerified': step == 'DONE',
    'access': <String, dynamic>{},
  },
  'tokens': tokens
      ? {
          'accessToken': 'a',
          'refreshToken': 'r',
          'expiresAt': '2030-01-01T00:00:00.000Z',
        }
      : null,
  'challenge': step == 'VERIFY_EMAIL'
      ? {
          'expiresAt': '2026-11-21T10:10:00.000Z',
          'nextSendAt': '2026-11-21T10:00:30.000Z',
        }
      : null,
};

void main() {
  group('AuthResponseModel', () {
    test('a gated sign-up carries the gate, the email and the challenge', () {
      final out = AuthResponseModel.fromJson(_auth('VERIFY_EMAIL')).toEntity();
      expect(out.session?.gate, AuthGate.verifyEmail);
      expect(out.session?.email, 'ngozi@example.com');
      expect(out.session?.accessToken, 'a');
      expect(out.challenge?.nextSendAt, DateTime.utc(2026, 11, 21, 10, 0, 30));
      expect(out.firstName, 'Ngozi');
    });

    test('DONE and ADD_PHONE are supported gates', () {
      expect(
        AuthResponseModel.fromJson(_auth('DONE')).toEntity().session?.gate,
        AuthGate.none,
      );
      expect(
        AuthResponseModel.fromJson(_auth('ADD_PHONE')).toEntity().session?.gate,
        AuthGate.addPhone,
      );
    });

    test('steps this app cannot finish never become a session', () {
      for (final step in [
        'MFA',
        'MFA_ENROL',
        'ACCEPT_TERMS',
        'SOMETHING_NEW',
      ]) {
        expect(
          AuthResponseModel.fromJson(_auth(step)).toEntity().session,
          isNull,
          reason: step,
        );
      }
    });

    test('no tokens means no session', () {
      expect(
        AuthResponseModel.fromJson(_auth('DONE', tokens: false))
            .toEntity()
            .session,
        isNull,
      );
    });
  });

  test('LookupResponseModel', () {
    final a = LookupResponseModel.fromJson({
      'state': 'EXISTS',
      'hasPassword': false,
      'providers': ['GOOGLE', 'APPLE', 'FUTURE'],
    }).toEntity();
    expect(a.exists, isTrue);
    expect(a.hasPassword, isFalse);
    expect(a.providers, {AuthProvider.google, AuthProvider.apple});
    final b = LookupResponseModel.fromJson({
      'state': 'NEW',
      'hasPassword': false,
    }).toEntity();
    expect(b.exists, isFalse);
    expect(b.providers, isEmpty);
  });

  test('PasswordCheckModel ignores problems it does not know', () {
    final c = PasswordCheckModel.fromJson({
      'ok': false,
      'problems': ['COMMON', 'EMAIL_LOCAL_PART', 'NEW_RULE'],
    }).toEntity();
    expect(c.problems, {
      PasswordProblem.common,
      PasswordProblem.emailLocalPart,
    });
  });
}
