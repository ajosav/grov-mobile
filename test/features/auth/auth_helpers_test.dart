import 'dart:math';

import 'package:app_mobile/core/platform/uuid_v7.dart';
import 'package:app_mobile/features/auth/domain/email_format.dart';
import 'package:app_mobile/features/auth/domain/entities/password_problem.dart';
import 'package:app_mobile/features/auth/domain/mask_email.dart';
import 'package:app_mobile/features/auth/domain/nigerian_phone.dart';
import 'package:app_mobile/features/auth/domain/password_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeNigerianPhone', () {
    test('accepts the shapes people type', () {
      const want = '+2348031234567';
      expect(normalizeNigerianPhone('0803 123 4567'), want);
      expect(normalizeNigerianPhone('803 123 4567'), want);
      expect(normalizeNigerianPhone('8031234567'), want);
      expect(normalizeNigerianPhone('+234 803 123 4567'), want);
      expect(normalizeNigerianPhone('2348031234567'), want);
      expect(normalizeNigerianPhone('(0803) 123-4567'), want);
    });

    test('rejects what cannot be a mobile number', () {
      expect(normalizeNigerianPhone(''), isNull);
      expect(normalizeNigerianPhone('080312345'), isNull); // too short
      expect(normalizeNigerianPhone('08031234567890'), isNull); // too long
      expect(normalizeNigerianPhone('0603 123 4567'), isNull); // not 7/8/9
      expect(normalizeNigerianPhone('abc'), isNull);
    });
  });

  group('localPasswordProblems', () {
    test('short and symbol-less', () {
      expect(localPasswordProblems('abc'), {
        PasswordProblem.tooShort,
        PasswordProblem.noSymbol,
      });
    });
    test('long but no symbol', () {
      expect(localPasswordProblems('abcdefgh1'), {PasswordProblem.noSymbol});
    });
    test('short but with a symbol', () {
      expect(localPasswordProblems('ab!'), {PasswordProblem.tooShort});
    });
    test('good enough locally', () {
      expect(localPasswordProblems('abcdefg!'), isEmpty);
    });
  });

  test('maskEmail keeps the start and the domain', () {
    expect(maskEmail('ngozi.adeyemi@gmail.com'), 'ng***@gmail.com');
    expect(maskEmail('a@x.com'), 'a***@x.com');
    expect(maskEmail('not-an-email'), 'not-an-email');
  });

  test('isPlausibleEmail', () {
    expect(isPlausibleEmail('ngozi@example.com'), isTrue);
    expect(isPlausibleEmail(' ngozi@example.com '), isTrue);
    expect(isPlausibleEmail('ngozi@example'), isFalse);
    expect(isPlausibleEmail('ngozi example.com'), isFalse);
    expect(isPlausibleEmail(''), isFalse);
  });

  group('uuidV7', () {
    test('has version 7, variant 10 and the timestamp up front', () {
      final at = DateTime.utc(2026, 11, 21, 3);
      final id = uuidV7(now: at, random: Random(1));
      expect(
        id,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
      final ms = int.parse(id.substring(0, 8) + id.substring(9, 13), radix: 16);
      expect(ms, at.millisecondsSinceEpoch);
    });

    test('is time ordered and unique', () {
      final a = uuidV7(now: DateTime.utc(2026), random: Random(1));
      final b = uuidV7(now: DateTime.utc(2027), random: Random(1));
      expect(a.compareTo(b), lessThan(0));
      expect(uuidV7(), isNot(uuidV7()));
    });
  });
}
