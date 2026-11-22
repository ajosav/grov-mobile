import 'package:app_mobile/features/auth/data/models/auth_response_model.dart';
import 'package:app_mobile/features/auth/data/models/code_verify_response_model.dart';
import 'package:app_mobile/features/auth/domain/entities/code_verification.dart';
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
  'challenge': null,
};

void main() {
  group('AuthResponseModel', () {
    test('DONE and ADD_PHONE are supported gates', () {
      final done = AuthResponseModel.fromJson(_auth('DONE')).toEntity();
      expect(done.session?.gate, AuthGate.none);
      expect(done.session?.email, 'ngozi@example.com');
      expect(done.session?.accessToken, 'a');
      expect(done.firstName, 'Ngozi');
      expect(
        AuthResponseModel.fromJson(_auth('ADD_PHONE')).toEntity().session?.gate,
        AuthGate.addPhone,
      );
    });

    test('steps this app cannot finish never become a session', () {
      for (final step in [
        'VERIFY_EMAIL',
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

  group('CodeVerifyResponseModel', () {
    test('SIGNED_IN carries the session', () {
      final v = CodeVerifyResponseModel.fromJson({
        'state': 'SIGNED_IN',
        'auth': _auth('DONE'),
        'registration': null,
      }).toEntity();
      expect(v, isA<CodeSignedIn>());
      expect((v as CodeSignedIn).outcome.session?.gate, AuthGate.none);
    });

    test('PROFILE_REQUIRED carries the ticket and its expiry', () {
      final v = CodeVerifyResponseModel.fromJson({
        'state': 'PROFILE_REQUIRED',
        'auth': null,
        'registration': {
          'ticket': 'abc.def',
          'expiresAt': '2026-11-22T10:15:00.000Z',
        },
      }).toEntity();
      expect(v, isA<CodeProfileRequired>());
      v as CodeProfileRequired;
      expect(v.ticket.ticket, 'abc.def');
      expect(v.ticket.expiresAt, DateTime.utc(2026, 11, 22, 10, 15));
    });

    test('an unknown state or a missing body opens nothing', () {
      final v = CodeVerifyResponseModel.fromJson({
        'state': 'SOMETHING_NEW',
        'auth': null,
        'registration': null,
      }).toEntity();
      expect(v, isA<CodeSignedIn>());
      expect((v as CodeSignedIn).outcome.session, isNull);
    });
  });
}
