/// The one error channel across the data boundary. Repositories return
/// [Result]; view models fold it into state. Widgets never see either.
sealed class const Failure([this.message]) {
  final String? message;
}

final class const OfflineFailure() extends Failure;

final class const TimeoutFailure() extends Failure;

final class const ValidationFailure(
  this.fields, [
  super.message,
  final String? code,
  final Map<String, Object?> params = const {},
]) extends Failure {
  final Map<String, List<String>> fields;
}

final class const BadRequestFailure([super.message, final String? code])
    extends Failure;

final class const UnauthorizedFailure() extends Failure;

final class const ForbiddenFailure([super.message]) extends Failure;

final class const NotFoundFailure() extends Failure;

final class const ConflictFailure([super.message, final String? code])
    extends Failure;

final class const RateLimitedFailure([
  super.message,
  final String? code,
  final Map<String, Object?> params = const {},
]) extends Failure;

final class const GoneFailure([super.message, final String? code])
    extends Failure;

final class const ServerFailure([super.message]) extends Failure;

final class const CacheFailure([super.message]) extends Failure;

final class const UnknownFailure([super.message]) extends Failure;
