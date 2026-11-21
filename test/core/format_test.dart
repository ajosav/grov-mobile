import 'package:flutter_test/flutter_test.dart';
import 'package:app_mobile/core/domain/money.dart';
import 'package:app_mobile/core/domain/time_format.dart';

void main() {
  group('formatNaira (integer kobo)', () {
    test(
      'groups thousands and drops .00',
      () => expect(formatNaira(18450000), '₦184,500'),
    );
    test(
      'shows kobo only when non-zero',
      () => expect(formatNaira(12345), '₦123.45'),
    );
    test(
      'can force kobo for exact charges',
      () => expect(formatNaira(400000, showKobo: true), '₦4,000.00'),
    );
    test(
      'uses a true minus before the symbol',
      () => expect(formatNaira(-120000), '−₦1,200'),
    );
    test(
      'optional plus on positives',
      () => expect(formatNaira(50000, plusSign: true), '+₦500'),
    );
    test('zero', () => expect(formatNaira(0), '₦0'));
    test(
      'large values stay exact (no float)',
      () => expect(formatNaira(9007199254740991), '₦90,071,992,547,409.91'),
    );
  });

  group('WAT time', () {
    test(
      'UTC 06:40 is 7:40am WAT',
      () => expect(formatClockWat(DateTime.utc(2026, 10, 14, 6, 40)), '7:40am'),
    );
    test('noon and midnight', () {
      expect(formatClockWat(DateTime.utc(2026, 1, 1, 11, 0)), '12:00pm');
      expect(formatClockWat(DateTime.utc(2026, 1, 1, 23, 5)), '12:05am');
    });
    test(
      'date rolls over in WAT',
      () => expect(
        formatDateWat(DateTime.utc(2026, 10, 14, 23, 30)),
        '15/10/2026',
      ),
    );
  });
}
