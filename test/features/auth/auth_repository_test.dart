import 'dart:convert';

import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/network/interceptors.dart';
import 'package:app_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_mobile/features/auth/data/datasources/device_identity_data_source.dart';
import 'package:app_mobile/features/auth/data/datasources/gated_auth_api.dart';
import 'package:app_mobile/features/auth/data/datasources/sign_on_api.dart';
import 'package:app_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_mobile/features/auth/domain/entities/code_verification.dart';
import 'package:app_mobile/features/auth/domain/entities/new_profile.dart';
import 'package:app_mobile/features/session/domain/entities/auth_gate.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorage() extends Mock implements FlutterSecureStorage {}

/// Answers every call with one canned response and remembers what it was sent.
class _Stub(final int status, final Object data) implements HttpClientAdapter {
  RequestOptions? last;
  Object? body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    last = options;
    body = options.data;
    return ResponseBody.fromString(
      jsonEncode(data),
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, dynamic> _ok(Object data, {int status = 200}) => {
  'status': true,
  'statusCode': status,
  'message': 'ok',
  'data': data,
};

Map<String, dynamic> _err(
  int status,
  String code, {
  Map<String, dynamic>? params,
}) => {
  'status': false,
  'statusCode': status,
  'message': 'developer text',
  'code': code,
  'errors': <String, dynamic>{},
  'params': ?params,
};

Map<String, dynamic> _authData(String step) => {
  'nextStep': step,
  'user': {
    'id': '0192',
    'firstName': 'Ngozi',
    'email': 'ngozi@example.com',
    'emailVerified': step == 'DONE',
    'access': <String, dynamic>{},
  },
  'tokens': {
    'accessToken': 'a',
    'refreshToken': 'r',
    'expiresAt': '2030-01-01T00:00:00.000Z',
  },
  'challenge': null,
};

void main() {
  late _MockStorage storage;
  setUp(() {
    storage = _MockStorage();
    when(() => storage.read(key: any(named: 'key')))
        .thenAnswer((_) async => null);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  AuthRepositoryImpl repo(_Stub stub) {
    final dio = Dio(BaseOptions(baseUrl: 'http://test'))
      ..httpClientAdapter = stub
      ..interceptors.add(FailureInterceptor());
    return AuthRepositoryImpl(
      AuthRemoteDataSource(
        SignOnApi(dio),
        GatedAuthApi(dio),
        DeviceIdentityDataSource(storage),
      ),
    );
  }

  const profile = NewProfile(
    ticket: 'ticket-abc',
    firstName: 'Ngozi',
    lastName: 'Okafor',
    phone: '+2348031234567',
    termsVersion: 'terms-test',
  );

  group('requests match the API contract', () {
    test('current terms version comes from the public client config', () async {
      final stub = _Stub(
        200,
        _ok({
          'legal': {
            'termsVersion': 'terms-current',
            'privacyVersion': 'privacy-current',
          },
        }),
      );

      final result = await repo(stub).getTermsVersion();

      expect(stub.last!.method, 'GET');
      expect(stub.last!.path, '/v1/config');
      expect(result.valueOrNull, 'terms-current');
    });

    test('requesting a code posts only the email and reads the times', () async {
      final stub = _Stub(
        200,
        _ok({
          'expiresAt': '2026-11-22T10:10:00.000Z',
          'nextSendAt': '2026-11-22T10:01:00.000Z',
        }),
      );
      final result = await repo(stub).requestCode('ngozi@example.com');
      expect(stub.last!.method, 'POST');
      expect(stub.last!.path, '/v1/auth/code/request');
      expect(stub.body, {'email': 'ngozi@example.com'});
      expect(result.valueOrNull?.nextSendAt, DateTime.utc(2026, 11, 22, 10, 1));
    });

    test('verifying posts email, code and a device with a v7 id', () async {
      final stub = _Stub(
        200,
        _ok({
          'state': 'SIGNED_IN',
          'auth': _authData('DONE'),
          'registration': null,
        }),
      );
      final result = await repo(stub).verifyCode('ngozi@example.com', '429107');

      expect(stub.last!.path, '/v1/auth/code/verify');
      final body = stub.body! as Map<String, dynamic>;
      expect(body['email'], 'ngozi@example.com');
      expect(body['code'], '429107');
      expect(body.containsKey('password'), isFalse);
      final device = body['device'] as Map<String, dynamic>;
      expect(device['platform'], anyOf('IOS', 'ANDROID'));
      expect(
        device['id'],
        matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab]')),
      );
      expect((device['name'] as String).length, lessThanOrEqualTo(80));
      final value = result.valueOrNull! as CodeSignedIn;
      expect(value.outcome.session?.gate, AuthGate.none);
    });

    test('a new address answers with a ticket, not a session', () async {
      final stub = _Stub(
        200,
        _ok({
          'state': 'PROFILE_REQUIRED',
          'auth': null,
          'registration': {
            'ticket': 'ticket-abc',
            'expiresAt': '2026-11-22T10:15:00.000Z',
          },
        }),
      );
      final result = await repo(stub).verifyCode('new@example.com', '429107');
      final value = result.valueOrNull! as CodeProfileRequired;
      expect(value.ticket.ticket, 'ticket-abc');
    });

    test('the device id is made once and stored', () async {
      await repo(
        _Stub(200, _ok({'state': 'SIGNED_IN', 'auth': _authData('DONE')})),
      ).verifyCode('a@b.co', '123456');
      final written =
          verify(
                () => storage.write(
                  key: 'app.device.id',
                  value: captureAny(named: 'value'),
                ),
              ).captured.single
              as String;

      // Next launch: the stored id comes back, nothing new is written.
      when(() => storage.read(key: 'app.device.id'))
          .thenAnswer((_) async => written);
      final stub = _Stub(
        200,
        _ok({'state': 'SIGNED_IN', 'auth': _authData('DONE')}),
      );
      await repo(stub).verifyCode('a@b.co', '123456');
      expect(((stub.body! as Map)['device'] as Map)['id'], written);
    });

    test('completing the profile sends the ticket, names, +234 phone, terms', () async {
      final stub = _Stub(201, _ok(_authData('DONE'), status: 201));
      final result = await repo(stub).completeProfile(profile);
      expect(stub.last!.path, '/v1/auth/code/complete');
      final body = stub.body! as Map<String, dynamic>;
      expect(body['ticket'], 'ticket-abc');
      expect(body['firstName'], 'Ngozi');
      expect(body['lastName'], 'Okafor');
      expect(body['phone'], '+2348031234567');
      expect(body['termsVersion'], 'terms-test');
      expect(body.containsKey('email'), isFalse, reason: 'the ticket knows it');
      expect(body.containsKey('password'), isFalse);
      expect(body['device'], isA<Map<String, dynamic>>());
      expect(result.valueOrNull?.session?.gate, AuthGate.none);
    });

    test('the phone path', () async {
      final stub = _Stub(200, _ok(_authData('DONE')));
      await repo(stub).completePhone('+2348031234567');
      expect(stub.last!.path, '/v1/auth/phone/complete');
      expect(stub.body, {'phone': '+2348031234567'});
    });
  });

  group('failures keep what the screens branch on', () {
    Future<Failure?> failureOf(
      int status,
      String code, {
      Map<String, dynamic>? params,
    }) async {
      final r = await repo(_Stub(status, _err(status, code, params: params)))
          .verifyCode('a@b.co', '000000');
      return r.failureOrNull;
    }

    test('wrong code: 422 OTP_INVALID', () async {
      final f = await failureOf(
        422,
        'OTP_INVALID',
        params: {'attemptsLeft': 2},
      );
      expect(f, isA<ValidationFailure>());
      expect((f! as ValidationFailure).code, 'OTP_INVALID');
      expect((f as ValidationFailure).params['attemptsLeft'], 2);
    });

    test('asking again too soon: 429 with the server nextSendAt', () async {
      final r = await repo(
        _Stub(
          429,
          _err(
            429,
            'OTP_RESEND_TOO_SOON',
            params: {'nextSendAt': '2026-11-22T10:00:30.000Z'},
          ),
        ),
      ).requestCode('a@b.co');
      expect(
        (r.failureOrNull! as RateLimitedFailure).params['nextSendAt'],
        '2026-11-22T10:00:30.000Z',
      );
    });

    test('an expired ticket: 422 OTP_REGISTRATION_INVALID', () async {
      final r = await repo(_Stub(422, _err(422, 'OTP_REGISTRATION_INVALID')))
          .completeProfile(profile);
      expect(
        (r.failureOrNull! as ValidationFailure).code,
        'OTP_REGISTRATION_INVALID',
      );
    });

    test('phone already used: 409 PHONE_TAKEN', () async {
      final r = await repo(_Stub(409, _err(409, 'PHONE_TAKEN')))
          .completeProfile(profile);
      expect((r.failureOrNull! as ConflictFailure).code, 'PHONE_TAKEN');
    });

    test('a suspended account: 403 ACCOUNT_SUSPENDED', () async {
      final f = await failureOf(403, 'ACCOUNT_SUSPENDED');
      expect((f! as ForbiddenFailure).code, 'ACCOUNT_SUSPENDED');
    });

    test('a dead network is Offline, not a crash', () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://test'))
        ..httpClientAdapter = _Offline()
        ..interceptors.add(FailureInterceptor());
      final r = await AuthRepositoryImpl(
        AuthRemoteDataSource(
          SignOnApi(dio),
          GatedAuthApi(dio),
          DeviceIdentityDataSource(storage),
        ),
      ).requestCode('a@b.co');
      expect(r.failureOrNull, isA<OfflineFailure>());
    });
  });
}

class _Offline() implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) => throw DioException(
    requestOptions: options,
    type: DioExceptionType.connectionError,
  );

  @override
  void close({bool force = false}) {}
}
