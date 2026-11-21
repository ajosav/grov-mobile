# Data layer

## Retrofit API (the only HTTP surface)

```dart
part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/v1/auth/refresh')
  Future<ApiResponse<RefreshResponseModel>> refresh(@Body() RefreshRequestModel body);
}
```

- One `*_api.dart` per feature in `data/datasources`. Paths, verbs, bodies and response shapes come from the backend `openapi.json`. Do not invent fields; if the contract is missing something, stop and ask.
- Return `ApiResponse<Model>` (`core/network/api_response.dart`, generic envelope). A thin `*_remote_data_source.dart` unwraps `.data` and returns models.
- Build the API with the app `Dio` (`getIt<Dio>()`) in `core/di`. Calls that must not trigger auth (refresh, public) use `buildBareDio()`.
- Per-call flags go through `@Extra({'skipAuth': true})`. Headers like `Idempotency-Key` use `@Header`.
- Retrofit is imported only in `data/` and `core/di`. Presentation and domain never see it.
- After any change: `dart run build_runner build --delete-conflicting-outputs`.

## Models (DTOs)

- `@JsonSerializable` in `data/models`, with `toEntity()` and `fromEntity()`. Entities carry no JSON.
- Request models implement `toJson`; response models implement `fromJson`. Use `createToJson: false` / `createFactory: false` to say which.
- Money in the API is `{kobo, currency}` with integer kobo. Parse to `int`. Never `double`.
- Lists are paged (`?limit=&cursor=`, `meta: { nextCursor, ... }`, about 20 rows).
- POSTs that create orders, payments, bookings or refunds send an `Idempotency-Key`. Store the key with the draft so a resume reads the result by key and never posts twice.

## Repository implementations

- `data/repositories/<name>_repository_impl.dart`, `implements` the domain interface, bound in DI against the interface.
- Return `Result`. Network calls: `guardApi(() => remote.call())`. Local calls: `guardLocal(...)`, streams: `guardStream(...)`. Never let an exception escape.
- Persist what must work offline in Drift in the same step (`offline.md`). Never persist auth, checkout or payment responses.
- Map models and Drift rows to entities; return entities only.

## Errors (`core/network`, `core/error`)

- `FailureInterceptor` maps `DioException` to `Failure` using `mapApiFailure` (branch on the stable error `code`, never `message`).
- Interceptor order: auth, single-flight refresh, failure map, debug log. Refresh and unauthenticated calls use the bare Dio so they cannot recurse.
- `Failure` cases: Offline, Timeout, Validation (field map), BadRequest, Unauthorized (after refresh fails: sign out), Forbidden, NotFound, Conflict, Server, Cache, Unknown. A new case needs a decision in `DECISIONS.md` and a state treatment in presentation. Copy for failures is in ARB, keyed by `code`.
- Large payloads decode off the UI isolate (`compute`).
