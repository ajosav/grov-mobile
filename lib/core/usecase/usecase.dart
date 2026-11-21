import '../error/result.dart';

/// One use case = one class = one application action. Presentation calls use
/// cases, never repositories. Use cases do not throw: failures come back as
/// `Err`.
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class UseCase<Output, Params> {
  Future<Result<Output>> call(Params params);
}

/// A use case that exposes a live stream (Drift `watch`, connectivity).
/// Errors arrive in-band as `Err` so a listener never dies on a failure.
// ignore: use_primary_constructors (no constructor by design: interface/static-only)
abstract interface class StreamUseCase<Output, Params> {
  Stream<Result<Output>> call(Params params);
}

/// For use cases that need no input.
final class const NoParams();
