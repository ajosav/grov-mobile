/// Turns what a person types ("0803 123 4567", "803 123 4567",
/// "+234 803 123 4567") into `+2348031234567`, or null when it cannot be a
/// Nigerian mobile number. The server checks it again.
String? normalizeNigerianPhone(String input) {
  var digits = input.replaceAll(RegExp(r'[^0-9+]'), '');
  if (digits.startsWith('+234')) {
    digits = digits.substring(4);
  } else if (digits.startsWith('234') && digits.length == 13) {
    digits = digits.substring(3);
  }
  digits = digits.replaceAll('+', '');
  if (digits.startsWith('0')) {
    digits = digits.substring(1);
  }
  if (!RegExp(r'^[789]\d{9}$').hasMatch(digits)) {
    return null;
  }
  return '+234$digits';
}
