DateTime _wat(DateTime at) => at.toUtc().add(const Duration(hours: 1));

String formatClockWat(DateTime at) {
  final t = _wat(at);
  final hour12 = t.hour % 12 == 0 ? 12 : t.hour % 12;
  final minute = t.minute.toString().padLeft(2, '0');
  return '$hour12:$minute${t.hour < 12 ? 'am' : 'pm'}';
}

String formatDateWat(DateTime at) {
  final t = _wat(at);
  return '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}/${t.year}';
}
