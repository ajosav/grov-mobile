// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_dao.dart';

// ignore_for_file: type=lint
mixin _$CacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $CacheEntriesTableTable get cacheEntriesTable =>
      attachedDatabase.cacheEntriesTable;
  CacheDaoManager get managers => CacheDaoManager(this);
}

class CacheDaoManager {
  final _$CacheDaoMixin _db;
  CacheDaoManager(this._db);
  $$CacheEntriesTableTableTableManager get cacheEntriesTable =>
      $$CacheEntriesTableTableTableManager(
        _db.attachedDatabase,
        _db.cacheEntriesTable,
      );
}
