import 'dart:math';

/// A UUIDv7 (time-ordered): 48-bit millisecond timestamp, then random bits.
/// The API asks for v7 device ids. [now] and [random] are test seams.
String uuidV7({DateTime? now, Random? random}) {
  final rng = random ?? Random.secure();
  final ms = (now ?? DateTime.now()).millisecondsSinceEpoch;
  final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
  for (var i = 0; i < 6; i++) {
    bytes[i] = (ms >> (8 * (5 - i))) & 0xff;
  }
  bytes[6] = (bytes[6] & 0x0f) | 0x70; // version 7
  bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant 10
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
