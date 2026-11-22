import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/auth/presentation/cubit/auth_error.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_factories.dart';
import '../../helpers/fake_auth_repository.dart';

void main() {
  late FakeAuthRepository repo;
  setUp(() => repo = FakeAuthRepository());

  group('phone', () {
    test('a good number is sent in +234 form and signs in', () async {
      repo.phoneResult = Result.ok(outcomeWith(AuthGate.none));
      final c = phoneCubitFor(repo);
      await c.submit('803 123 4567');
      expect(repo.calls, ['phone:+2348031234567']);
      expect(c.state.signedInSession, isNotNull);
      await c.close();
    });

    test(
      'a bad number never reaches the server; editing clears the error',
      () async {
        final c = phoneCubitFor(repo);
        await c.submit('123');
        expect(c.state.error, AuthError.phoneInvalid);
        expect(repo.calls, isEmpty);
        c.phoneEdited();
        expect(c.state.error, isNull);
        await c.close();
      },
    );

    test('a number on another account is reported', () async {
      repo.phoneResult = const Result.err(ConflictFailure('x', 'PHONE_TAKEN'));
      final c = phoneCubitFor(repo);
      await c.submit('803 123 4567');
      expect(c.state.error, AuthError.phoneTaken);
      await c.close();
    });
  });

  test('every failure maps to a screen error, and none to a crash', () {
    expect(authErrorOf(const OfflineFailure()), AuthError.offline);
    expect(authErrorOf(const TimeoutFailure()), AuthError.timeout);
    expect(authErrorOf(const ServerFailure()), AuthError.server);
    expect(
      authErrorOf(const ConflictFailure('x', 'PHONE_ALREADY_SET')),
      AuthError.phoneAlreadySet,
    );
    expect(
      authErrorOf(const ConflictFailure('x', 'EMAIL_TAKEN')),
      AuthError.emailTaken,
    );
    expect(
      authErrorOf(const ConflictFailure('x', 'NEW_CODE')),
      AuthError.unknown,
    );
    expect(authErrorOf(const UnknownFailure()), AuthError.unknown);
    expect(authErrorOf(const NotFoundFailure()), AuthError.unknown);
    expect(authErrorOf(const CacheFailure()), AuthError.unknown);
    expect(
      authErrorOf(const BadRequestFailure('x', 'AUTH_TERMS_VERSION_STALE')),
      AuthError.termsStale,
    );
    expect(
      authErrorOf(const RateLimitedFailure('x', 'AUTH_ACCOUNT_LOCKED')),
      AuthError.accountLocked,
    );
    expect(
      authErrorOf(const ForbiddenFailure('x', 'ACCOUNT_SUSPENDED')),
      AuthError.accountSuspended,
    );
    expect(
      authErrorOf(const ForbiddenFailure('x', 'AUTH_ACCOUNT_LOCKED')),
      AuthError.accountLocked,
    );
    expect(
      authErrorOf(const ValidationFailure({}, 'x', 'OTP_REGISTRATION_INVALID')),
      AuthError.ticketExpired,
    );
    expect(
      authErrorOf(const UnauthorizedFailure()),
      AuthError.unknown,
      reason: 'there are no passwords: a 401 is not a wrong password',
    );
    expect(nextSendAtOf(const OfflineFailure()), isNull);
  });
}
