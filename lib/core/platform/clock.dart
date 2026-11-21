/// Injectable time so repositories and view models are testable.
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class Clock {
  DateTime now();
}

class const SystemClock() implements Clock {
  @override
  DateTime now() => DateTime.now();
}
