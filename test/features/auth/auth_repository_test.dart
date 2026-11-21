import 'dart:convert';

import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/network/interceptors.dart';
import 'package:app_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_mobile/features/auth/data/datasources/device_identity_data_source.dart';
import 'package:app_mobile/features/auth/data/datasources/gated_auth_api.dart';
import 'package:app_mobile/features/auth/data/datasources/sign_on_api.dart';
import 'package:app_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_mobile/features/auth/domain/entities/new_account.dart';
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

    test(
      'log-in posts the PASSWORD method and a device with a v7 id',
      () async {
        final stub = _Stub(200, _ok(_authData('DONE')));
        final result = await repo(stub)
            .logIn('ngozi@example.com', 'Secret!123');

        expect(stub.last!.path, '/v1/auth/login');
        final body = stub.body! as Map<String, dynamic>;
        expect(body['method'], 'PASSWORD');
        expect(body['email'], 'ngozi@example.com');
        expect(body['password'], 'Secret!123');
        final device = body['device'] as Map<String, dynamic>;
        expect(device['platform'], anyOf('IOS', 'ANDROID'));
        expect(
          device['id'],
          matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab]')),
        );
        expect((device['name'] as String).length, lessThanOrEqualTo(80));
        expect(result.valueOrNull?.session?.gate, AuthGate.none);
      },
    );

    test('the device id is made once and stored', () async {
      await repo(_Stub(200, _ok(_authData('DONE')))).logIn('a@b.co', 'x');
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
      final stub = _Stub(200, _ok(_authData('DONE')));
      await repo(stub).logIn('a@b.co', 'x');
      expect(((stub.body! as Map)['device'] as Map)['id'], written);
    });

    test('sign-up sends the +234 number and the terms version', () async {
      final stub = _Stub(201, _ok(_authData('VERIFY_EMAIL'), status: 201));
      final result = await repo(stub).signUp(
        const NewAccount(
          email: 'ngozi@example.com',
          firstName: 'Ngozi',
          lastName: 'Okafor',
          phone: '+2348031234567',
          password: 'Secret!123',
          termsVersion: 'terms-test',
        ),
      );
      expect(stub.last!.path, '/v1/auth/signup');
      final body = stub.body! as Map<String, dynamic>;
      expect(body['phone'], '+2348031234567');
      expect(body['firstName'], 'Ngozi');
      expect(body['lastName'], 'Okafor');
      expect(body['termsVersion'], 'terms-test');
      expect(result.valueOrNull?.session?.gate, AuthGate.verifyEmail);
      expect(result.valueOrNull?.session?.email, 'ngozi@example.com');
    });

    test(
      'sign-up leaves the optional last name out when it is empty',
      () async {
        final stub = _Stub(201, _ok(_authData('VERIFY_EMAIL'), status: 201));
        await repo(stub).signUp(
          const NewAccount(
            email: 'ngozi@example.com',
            firstName: 'Ngozi',
            lastName: '',
            phone: '+2348031234567',
            password: 'Secret!123',
            termsVersion: 'terms-test',
          ),
        );
        final body = stub.body! as Map<String, dynamic>;
        expect(
          body.containsKey('lastName'),
          isFalse,
          reason: 'the API field is optional: no empty string',
        );
        expect(body['firstName'], 'Ngozi');
      },
    );

    test('the password check leaves email out when there is none', () async {
      final stub = _Stub(200, _ok({'ok': true, 'problems': <String>[]}));
      await repo(stub).checkPassword('Secret!123');
      expect(stub.body, {'password': 'Secret!123'});
      await repo(stub).checkPassword('Secret!123', email: 'n@e.co');
      expect(stub.body, {'password': 'Secret!123', 'email': 'n@e.co'});
    });

    test('the email code, resend, change-address and phone paths', () async {
      var stub = _Stub(200, _ok(_authData('DONE')));
      await repo(stub).verifyEmail('429107');
      expect(stub.last!.path, '/v1/auth/email/verify');
      expect(stub.body, {'code': '429107'});

      stub = _Stub(
        200,
        _ok({
          'expiresAt': '2026-11-21T10:10:00.000Z',
          'nextSendAt': '2026-11-21T10:01:00.000Z',
        }),
      );
      final resent = await repo(stub).resendEmailCode();
      expect(stub.last!.path, '/v1/auth/email/resend');
      expect(resent.valueOrNull?.nextSendAt, DateTime.utc(2026, 11, 21, 10, 1));

      await repo(stub).changeEmailAddress('new@example.com');
      expect(stub.last!.path, '/v1/auth/email/change-address');
      expect(stub.body, {'newEmail': 'new@example.com'});

      stub = _Stub(200, _ok(_authData('DONE')));
      await repo(stub).completePhone('+2348031234567');
      expect(stub.last!.path, '/v1/auth/phone/complete');
      expect(stub.body, {'phone': '+2348031234567'});
    });

    test('reset: link check, then reset with a device', () async {
      var stub = _Stub(200, _ok({'valid': true}));
      expect((await repo(stub).checkResetLink('t' * 24)).valueOrNull, isTrue);
      expect(stub.last!.path, '/v1/auth/password/reset/check');

      stub = _Stub(200, _ok(_authData('DONE')));
      await repo(stub).resetPassword('t' * 24, 'New!Pass123');
      expect(stub.last!.path, '/v1/auth/password/reset');
      final body = stub.body! as Map<String, dynamic>;
      expect(body['token'], 't' * 24);
      expect(body['device'], isA<Map<String, dynamic>>());

      stub = _Stub(
        202,
        _ok({'nextSendAt': '2026-11-21T10:00:30.000Z'}, status: 202),
      );
      final forgot = await repo(stub).requestPasswordReset('a@b.co');
      expect(stub.last!.path, '/v1/auth/password/forgot');
      expect(forgot.valueOrNull, DateTime.utc(2026, 11, 21, 10, 0, 30));
    });
  });

  group('failures keep what the screens branch on', () {
    Future<Failure?> failureOf(
      int status,
      String code, {
      Map<String, dynamic>? params,
    }) async {
      final r = await repo(_Stub(status, _err(status, code, params: params)))
          .verifyEmail('000000');
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
    });

    test('resend too soon: 429 with the server nextSendAt', () async {
      final f = await failureOf(
        429,
        'OTP_RESEND_TOO_SOON',
        params: {'nextSendAt': '2026-11-21T10:00:30.000Z'},
      );
      expect(
        (f! as RateLimitedFailure).params['nextSendAt'],
        '2026-11-21T10:00:30.000Z',
      );
    });

    test('wrong password is a 401', () async {
      final r = await repo(_Stub(401, _err(401, 'AUTH_INVALID_CREDENTIALS')))
          .logIn('a@b.co', 'x');
      expect(r.failureOrNull, isA<UnauthorizedFailure>());
    });

    test('used reset link: 410', () async {
      final r = await repo(_Stub(410, _err(410, 'RESET_LINK_USED')))
          .resetPassword('t' * 24, 'x');
      expect((r.failureOrNull! as GoneFailure).code, 'RESET_LINK_USED');
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
      ).lookup('a@b.co');
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
