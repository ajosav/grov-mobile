import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_mobile/core/error/failure.dart';
import 'package:app_mobile/core/error/result.dart';
import 'package:app_mobile/features/session/domain/entities/session.dart';
import 'package:app_mobile/features/session/domain/repositories/session_repository.dart';
import 'package:app_mobile/features/session/presentation/cubit/session_cubit.dart';
import 'package:app_mobile/features/session/presentation/cubit/session_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/cubit_factories.dart';

class _MockRepo() extends Mock implements SessionRepository {}

final _a = Session(
  accessToken: 'a1',
  refreshToken: 'r1',
  expiresAt: DateTime.utc(2030),
);
final _b = Session(
  accessToken: 'a2',
  refreshToken: 'r2',
  expiresAt: DateTime.utc(2030),
);

void main() {
  late _MockRepo repo;
  setUp(() {
    repo = _MockRepo();
    registerFallbackValue(_a);
    when(() => repo.clear()).thenAnswer((_) async => const Result.ok(null));
    when(() => repo.save(any())).thenAnswer((_) async => const Result.ok(null));
  });

  SessionCubit build() => sessionCubitFor(repo);

  blocTest<SessionCubit, SessionState>(
    'restore with nothing stored signs out',
    setUp: () =>
        when(() => repo.restore())
            .thenAnswer((_) async => const Result.ok(null)),
    build: build,
    act: (c) => c.restore(),
    expect: () => [const SessionState.signedOut()],
  );

  blocTest<SessionCubit, SessionState>(
    'restore with a stored session signs in and exposes the token',
    setUp: () =>
        when(() => repo.restore()).thenAnswer((_) async => Result.ok(_a)),
    build: build,
    act: (c) => c.restore(),
    expect: () => [SessionState.signedIn(_a)],
    verify: (c) => expect(c.accessToken, 'a1'),
  );

  blocTest<SessionCubit, SessionState>(
    'an unreadable store is treated as signed out',
    setUp: () =>
        when(() => repo.restore())
            .thenAnswer((_) async => const Result.err(CacheFailure('boom'))),
    build: build,
    act: (c) => c.restore(),
    expect: () => [const SessionState.signedOut()],
  );

  blocTest<SessionCubit, SessionState>(
    'refresh rotates the token pair',
    setUp: () =>
        when(() => repo.refresh(_a)).thenAnswer((_) async => Result.ok(_b)),
    build: build,
    seed: () => SessionState.signedIn(_a),
    act: (c) async => expect(await c.refresh(), 'a2'),
    expect: () => [SessionState.signedIn(_b)],
  );

  blocTest<SessionCubit, SessionState>(
    'a revoked session signs out',
    setUp: () =>
        when(() => repo.refresh(_a))
            .thenAnswer((_) async => const Result.ok(null)),
    build: build,
    seed: () => SessionState.signedIn(_a),
    act: (c) async => expect(await c.refresh(), isNull),
    expect: () => [const SessionState.signedOut()],
    verify: (_) => verify(() => repo.clear()).called(1),
  );

  blocTest<SessionCubit, SessionState>(
    'offline during refresh keeps the session (a bad link is not a sign-out)',
    setUp: () =>
        when(() => repo.refresh(_a))
            .thenAnswer((_) async => const Result.err(OfflineFailure())),
    build: build,
    seed: () => SessionState.signedIn(_a),
    act: (c) async => expect(await c.refresh(), isNull),
    expect: () => <SessionState>[],
    verify: (_) => verifyNever(() => repo.clear()),
  );
}
