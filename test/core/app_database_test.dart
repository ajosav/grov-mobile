import 'package:flutter_test/flutter_test.dart';
import 'package:app_mobile/core/database/app_database.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase.inMemory());
  tearDown(() => db.close());

  test('settings row exists with defaults on first open', () async {
    final row = await db.settingsDao.read();
    expect(
      (row.appearance, row.lowEnd, row.rememberedEmail),
      ('system', 'auto', null),
    );
  });

  test('settings stream emits changes', () async {
    final appearances = db.settingsDao.watch().map((r) => r.appearance);
    final expectation = expectLater(
      appearances,
      emitsInOrder(['system', 'dark']),
    );
    await Future<void>.delayed(Duration.zero);
    await db.settingsDao.setAppearance('dark');
    await expectation;
  });

  test('drafts upsert, find and remove', () async {
    final t = DateTime.utc(2026, 11, 21);
    await db.draftsDao.upsert('sign_on', '{"step":1}', t);
    await db.draftsDao.upsert('sign_on', '{"step":2}', t);
    expect((await db.draftsDao.find('sign_on'))?.payload, '{"step":2}');
    await db.draftsDao.remove('sign_on');
    expect(await db.draftsDao.find('sign_on'), isNull);
  });

  test('last synced is the newest cache entry, null when empty', () async {
    expect(await db.cacheDao.watchLastSyncedAt().first, isNull);
    await db.cacheDao.put('catalogue', '[]', DateTime.utc(2026, 11, 21, 6));
    await db.cacheDao.put('plan', '{}', DateTime.utc(2026, 11, 21, 8));
    final latest = await db.cacheDao.watchLastSyncedAt().first;
    expect(
      latest!.isAtSameMomentAs(DateTime.utc(2026, 11, 21, 8)),
      isTrue,
    ); // Drift returns local time
  });
}
