String formatNaira(int kobo, {bool showKobo = false, bool plusSign = false}) {
  final negative = kobo < 0;
  final abs = kobo.abs();
  final naira = abs ~/ 100;
  final rest = abs % 100;
  final grouped = naira.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  final tail = (showKobo || rest != 0)
      ? '.${rest.toString().padLeft(2, '0')}'
      : '';
  final sign = negative ? '−' : (plusSign && kobo > 0 ? '+' : '');
  return '$sign₦$grouped$tail';
}
