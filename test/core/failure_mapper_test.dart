import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/network/failure_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> body(String code, {Map<String, dynamic>? params}) => {
    'status': false,
    'message': 'developer text',
    'code': code,
    'errors': <String, dynamic>{},
    'params': ?params,
  };

  test('422 keeps the code and params (wrong email code, attempts left)', () {
    final f = mapApiFailure(
      422,
      body('OTP_INVALID', params: {'attemptsLeft': 3}),
    );
    expect(f, isA<ValidationFailure>());
    f as ValidationFailure;
    expect(f.code, 'OTP_INVALID');
    expect(f.params['attemptsLeft'], 3);
  });

  test('429 is rate limited and carries nextSendAt', () {
    final f = mapApiFailure(
      429,
      body(
        'OTP_RESEND_TOO_SOON',
        params: {'nextSendAt': '2026-11-21T10:00:00Z'},
      ),
    );
    expect(f, isA<RateLimitedFailure>());
    expect((f as RateLimitedFailure).code, 'OTP_RESEND_TOO_SOON');
    expect(f.params['nextSendAt'], '2026-11-21T10:00:00Z');
  });

  test('410 is gone, with the code that says used or expired', () {
    final f = mapApiFailure(410, body('RESET_LINK_USED'));
    expect(f, isA<GoneFailure>());
    expect((f as GoneFailure).code, 'RESET_LINK_USED');
  });

  test('409 keeps its code; 401 and 403 stay as they were', () {
    expect(
      (mapApiFailure(409, body('EMAIL_TAKEN')) as ConflictFailure).code,
      'EMAIL_TAKEN',
    );
    expect(
      mapApiFailure(401, body('AUTH_INVALID_CREDENTIALS')),
      isA<UnauthorizedFailure>(),
    );
    expect(
      mapApiFailure(403, body('AUTH_ACCOUNT_LOCKED')),
      isA<ForbiddenFailure>(),
    );
  });

  test('a body without params gives an empty map, not a crash', () {
    final f = mapApiFailure(422, {'code': 'PHONE_INVALID'});
    expect((f as ValidationFailure).params, isEmpty);
    expect(mapApiFailure(429, 'not a map'), isA<RateLimitedFailure>());
  });
}
