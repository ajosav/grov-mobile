// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DeviceSettingsTableTable extends DeviceSettingsTable
    with TableInfo<$DeviceSettingsTableTable, DeviceSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appearanceMeta = const VerificationMeta(
    'appearance',
  );
  @override
  late final GeneratedColumn<String> appearance = GeneratedColumn<String>(
    'appearance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _lowEndMeta = const VerificationMeta('lowEnd');
  @override
  late final GeneratedColumn<String> lowEnd = GeneratedColumn<String>(
    'low_end',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('auto'),
  );
  static const VerificationMeta _rememberedEmailMeta = const VerificationMeta(
    'rememberedEmail',
  );
  @override
  late final GeneratedColumn<String> rememberedEmail = GeneratedColumn<String>(
    'remembered_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    appearance,
    lowEnd,
    rememberedEmail,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('appearance')) {
      context.handle(
        _appearanceMeta,
        appearance.isAcceptableOrUnknown(data['appearance']!, _appearanceMeta),
      );
    }
    if (data.containsKey('low_end')) {
      context.handle(
        _lowEndMeta,
        lowEnd.isAcceptableOrUnknown(data['low_end']!, _lowEndMeta),
      );
    }
    if (data.containsKey('remembered_email')) {
      context.handle(
        _rememberedEmailMeta,
        rememberedEmail.isAcceptableOrUnknown(
          data['remembered_email']!,
          _rememberedEmailMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      appearance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}appearance'],
      )!,
      lowEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}low_end'],
      )!,
      rememberedEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remembered_email'],
      ),
    );
  }

  @override
  $DeviceSettingsTableTable createAlias(String alias) {
    return $DeviceSettingsTableTable(attachedDatabase, alias);
  }
}

class DeviceSettingsRow extends DataClass
    implements Insertable<DeviceSettingsRow> {
  final int id;
  final String appearance;
  final String lowEnd;
  final String? rememberedEmail;
  const DeviceSettingsRow({
    required this.id,
    required this.appearance,
    required this.lowEnd,
    this.rememberedEmail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['appearance'] = Variable<String>(appearance);
    map['low_end'] = Variable<String>(lowEnd);
    if (!nullToAbsent || rememberedEmail != null) {
      map['remembered_email'] = Variable<String>(rememberedEmail);
    }
    return map;
  }

  DeviceSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return DeviceSettingsTableCompanion(
      id: Value(id),
      appearance: Value(appearance),
      lowEnd: Value(lowEnd),
      rememberedEmail: rememberedEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(rememberedEmail),
    );
  }

  factory DeviceSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      appearance: serializer.fromJson<String>(json['appearance']),
      lowEnd: serializer.fromJson<String>(json['lowEnd']),
      rememberedEmail: serializer.fromJson<String?>(json['rememberedEmail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'appearance': serializer.toJson<String>(appearance),
      'lowEnd': serializer.toJson<String>(lowEnd),
      'rememberedEmail': serializer.toJson<String?>(rememberedEmail),
    };
  }

  DeviceSettingsRow copyWith({
    int? id,
    String? appearance,
    String? lowEnd,
    Value<String?> rememberedEmail = const Value.absent(),
  }) => DeviceSettingsRow(
    id: id ?? this.id,
    appearance: appearance ?? this.appearance,
    lowEnd: lowEnd ?? this.lowEnd,
    rememberedEmail: rememberedEmail.present
        ? rememberedEmail.value
        : this.rememberedEmail,
  );
  DeviceSettingsRow copyWithCompanion(DeviceSettingsTableCompanion data) {
    return DeviceSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      appearance: data.appearance.present
          ? data.appearance.value
          : this.appearance,
      lowEnd: data.lowEnd.present ? data.lowEnd.value : this.lowEnd,
      rememberedEmail: data.rememberedEmail.present
          ? data.rememberedEmail.value
          : this.rememberedEmail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceSettingsRow(')
          ..write('id: $id, ')
          ..write('appearance: $appearance, ')
          ..write('lowEnd: $lowEnd, ')
          ..write('rememberedEmail: $rememberedEmail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, appearance, lowEnd, rememberedEmail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceSettingsRow &&
          other.id == this.id &&
          other.appearance == this.appearance &&
          other.lowEnd == this.lowEnd &&
          other.rememberedEmail == this.rememberedEmail);
}

class DeviceSettingsTableCompanion extends UpdateCompanion<DeviceSettingsRow> {
  final Value<int> id;
  final Value<String> appearance;
  final Value<String> lowEnd;
  final Value<String?> rememberedEmail;
  const DeviceSettingsTableCompanion({
    this.id = const Value.absent(),
    this.appearance = const Value.absent(),
    this.lowEnd = const Value.absent(),
    this.rememberedEmail = const Value.absent(),
  });
  DeviceSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.appearance = const Value.absent(),
    this.lowEnd = const Value.absent(),
    this.rememberedEmail = const Value.absent(),
  });
  static Insertable<DeviceSettingsRow> custom({
    Expression<int>? id,
    Expression<String>? appearance,
    Expression<String>? lowEnd,
    Expression<String>? rememberedEmail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appearance != null) 'appearance': appearance,
      if (lowEnd != null) 'low_end': lowEnd,
      if (rememberedEmail != null) 'remembered_email': rememberedEmail,
    });
  }

  DeviceSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? appearance,
    Value<String>? lowEnd,
    Value<String?>? rememberedEmail,
  }) {
    return DeviceSettingsTableCompanion(
      id: id ?? this.id,
      appearance: appearance ?? this.appearance,
      lowEnd: lowEnd ?? this.lowEnd,
      rememberedEmail: rememberedEmail ?? this.rememberedEmail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appearance.present) {
      map['appearance'] = Variable<String>(appearance.value);
    }
    if (lowEnd.present) {
      map['low_end'] = Variable<String>(lowEnd.value);
    }
    if (rememberedEmail.present) {
      map['remembered_email'] = Variable<String>(rememberedEmail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('appearance: $appearance, ')
          ..write('lowEnd: $lowEnd, ')
          ..write('rememberedEmail: $rememberedEmail')
          ..write(')'))
        .toString();
  }
}

class $DraftsTableTable extends DraftsTable
    with TableInfo<$DraftsTableTable, DraftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, payload, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drafts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  DraftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DraftsTableTable createAlias(String alias) {
    return $DraftsTableTable(attachedDatabase, alias);
  }
}

class DraftRow extends DataClass implements Insertable<DraftRow> {
  final String key;
  final String payload;
  final DateTime updatedAt;
  const DraftRow({
    required this.key,
    required this.payload,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['payload'] = Variable<String>(payload);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DraftsTableCompanion toCompanion(bool nullToAbsent) {
    return DraftsTableCompanion(
      key: Value(key),
      payload: Value(payload),
      updatedAt: Value(updatedAt),
    );
  }

  factory DraftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftRow(
      key: serializer.fromJson<String>(json['key']),
      payload: serializer.fromJson<String>(json['payload']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'payload': serializer.toJson<String>(payload),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DraftRow copyWith({String? key, String? payload, DateTime? updatedAt}) =>
      DraftRow(
        key: key ?? this.key,
        payload: payload ?? this.payload,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DraftRow copyWithCompanion(DraftsTableCompanion data) {
    return DraftRow(
      key: data.key.present ? data.key.value : this.key,
      payload: data.payload.present ? data.payload.value : this.payload,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftRow(')
          ..write('key: $key, ')
          ..write('payload: $payload, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, payload, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftRow &&
          other.key == this.key &&
          other.payload == this.payload &&
          other.updatedAt == this.updatedAt);
}

class DraftsTableCompanion extends UpdateCompanion<DraftRow> {
  final Value<String> key;
  final Value<String> payload;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DraftsTableCompanion({
    this.key = const Value.absent(),
    this.payload = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftsTableCompanion.insert({
    required String key,
    required String payload,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       payload = Value(payload),
       updatedAt = Value(updatedAt);
  static Insertable<DraftRow> custom({
    Expression<String>? key,
    Expression<String>? payload,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (payload != null) 'payload': payload,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftsTableCompanion copyWith({
    Value<String>? key,
    Value<String>? payload,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DraftsTableCompanion(
      key: key ?? this.key,
      payload: payload ?? this.payload,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftsTableCompanion(')
          ..write('key: $key, ')
          ..write('payload: $payload, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CacheEntriesTableTable extends CacheEntriesTable
    with TableInfo<$CacheEntriesTableTable, CacheEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, payload, syncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  CacheEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheEntryRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CacheEntriesTableTable createAlias(String alias) {
    return $CacheEntriesTableTable(attachedDatabase, alias);
  }
}

class CacheEntryRow extends DataClass implements Insertable<CacheEntryRow> {
  final String key;
  final String payload;
  final DateTime syncedAt;
  const CacheEntryRow({
    required this.key,
    required this.payload,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['payload'] = Variable<String>(payload);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CacheEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return CacheEntriesTableCompanion(
      key: Value(key),
      payload: Value(payload),
      syncedAt: Value(syncedAt),
    );
  }

  factory CacheEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheEntryRow(
      key: serializer.fromJson<String>(json['key']),
      payload: serializer.fromJson<String>(json['payload']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'payload': serializer.toJson<String>(payload),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CacheEntryRow copyWith({String? key, String? payload, DateTime? syncedAt}) =>
      CacheEntryRow(
        key: key ?? this.key,
        payload: payload ?? this.payload,
        syncedAt: syncedAt ?? this.syncedAt,
      );
  CacheEntryRow copyWithCompanion(CacheEntriesTableCompanion data) {
    return CacheEntryRow(
      key: data.key.present ? data.key.value : this.key,
      payload: data.payload.present ? data.payload.value : this.payload,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntryRow(')
          ..write('key: $key, ')
          ..write('payload: $payload, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, payload, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheEntryRow &&
          other.key == this.key &&
          other.payload == this.payload &&
          other.syncedAt == this.syncedAt);
}

class CacheEntriesTableCompanion extends UpdateCompanion<CacheEntryRow> {
  final Value<String> key;
  final Value<String> payload;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CacheEntriesTableCompanion({
    this.key = const Value.absent(),
    this.payload = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheEntriesTableCompanion.insert({
    required String key,
    required String payload,
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       payload = Value(payload),
       syncedAt = Value(syncedAt);
  static Insertable<CacheEntryRow> custom({
    Expression<String>? key,
    Expression<String>? payload,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (payload != null) 'payload': payload,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheEntriesTableCompanion copyWith({
    Value<String>? key,
    Value<String>? payload,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CacheEntriesTableCompanion(
      key: key ?? this.key,
      payload: payload ?? this.payload,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntriesTableCompanion(')
          ..write('key: $key, ')
          ..write('payload: $payload, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DeviceSettingsTableTable deviceSettingsTable =
      $DeviceSettingsTableTable(this);
  late final $DraftsTableTable draftsTable = $DraftsTableTable(this);
  late final $CacheEntriesTableTable cacheEntriesTable =
      $CacheEntriesTableTable(this);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final DraftsDao draftsDao = DraftsDao(this as AppDatabase);
  late final CacheDao cacheDao = CacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    deviceSettingsTable,
    draftsTable,
    cacheEntriesTable,
  ];
}

typedef $$DeviceSettingsTableTableCreateCompanionBuilder =
    DeviceSettingsTableCompanion Function({
      Value<int> id,
      Value<String> appearance,
      Value<String> lowEnd,
      Value<String?> rememberedEmail,
    });
typedef $$DeviceSettingsTableTableUpdateCompanionBuilder =
    DeviceSettingsTableCompanion Function({
      Value<int> id,
      Value<String> appearance,
      Value<String> lowEnd,
      Value<String?> rememberedEmail,
    });

class $$DeviceSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceSettingsTableTable> {
  $$DeviceSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appearance => $composableBuilder(
    column: $table.appearance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lowEnd => $composableBuilder(
    column: $table.lowEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rememberedEmail => $composableBuilder(
    column: $table.rememberedEmail,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeviceSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceSettingsTableTable> {
  $$DeviceSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appearance => $composableBuilder(
    column: $table.appearance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lowEnd => $composableBuilder(
    column: $table.lowEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rememberedEmail => $composableBuilder(
    column: $table.rememberedEmail,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeviceSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceSettingsTableTable> {
  $$DeviceSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get appearance => $composableBuilder(
    column: $table.appearance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lowEnd =>
      $composableBuilder(column: $table.lowEnd, builder: (column) => column);

  GeneratedColumn<String> get rememberedEmail => $composableBuilder(
    column: $table.rememberedEmail,
    builder: (column) => column,
  );
}

class $$DeviceSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceSettingsTableTable,
          DeviceSettingsRow,
          $$DeviceSettingsTableTableFilterComposer,
          $$DeviceSettingsTableTableOrderingComposer,
          $$DeviceSettingsTableTableAnnotationComposer,
          $$DeviceSettingsTableTableCreateCompanionBuilder,
          $$DeviceSettingsTableTableUpdateCompanionBuilder,
          (
            DeviceSettingsRow,
            BaseReferences<
              _$AppDatabase,
              $DeviceSettingsTableTable,
              DeviceSettingsRow
            >,
          ),
          DeviceSettingsRow,
          PrefetchHooks Function()
        > {
  $$DeviceSettingsTableTableTableManager(
    _$AppDatabase db,
    $DeviceSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DeviceSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> appearance = const Value.absent(),
                Value<String> lowEnd = const Value.absent(),
                Value<String?> rememberedEmail = const Value.absent(),
              }) => DeviceSettingsTableCompanion(
                id: id,
                appearance: appearance,
                lowEnd: lowEnd,
                rememberedEmail: rememberedEmail,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> appearance = const Value.absent(),
                Value<String> lowEnd = const Value.absent(),
                Value<String?> rememberedEmail = const Value.absent(),
              }) => DeviceSettingsTableCompanion.insert(
                id: id,
                appearance: appearance,
                lowEnd: lowEnd,
                rememberedEmail: rememberedEmail,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DeviceSettingsTableTable, DeviceSettingsRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $DeviceSettingsTableTable,
                    DeviceSettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeviceSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceSettingsTableTable,
      DeviceSettingsRow,
      $$DeviceSettingsTableTableFilterComposer,
      $$DeviceSettingsTableTableOrderingComposer,
      $$DeviceSettingsTableTableAnnotationComposer,
      $$DeviceSettingsTableTableCreateCompanionBuilder,
      $$DeviceSettingsTableTableUpdateCompanionBuilder,
      (
        DeviceSettingsRow,
        BaseReferences<
          _$AppDatabase,
          $DeviceSettingsTableTable,
          DeviceSettingsRow
        >,
      ),
      DeviceSettingsRow,
      PrefetchHooks Function()
    >;
typedef $$DraftsTableTableCreateCompanionBuilder =
    DraftsTableCompanion Function({
      required String key,
      required String payload,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DraftsTableTableUpdateCompanionBuilder =
    DraftsTableCompanion Function({
      Value<String> key,
      Value<String> payload,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DraftsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DraftsTableTable> {
  $$DraftsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DraftsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftsTableTable> {
  $$DraftsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DraftsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftsTableTable> {
  $$DraftsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DraftsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftsTableTable,
          DraftRow,
          $$DraftsTableTableFilterComposer,
          $$DraftsTableTableOrderingComposer,
          $$DraftsTableTableAnnotationComposer,
          $$DraftsTableTableCreateCompanionBuilder,
          $$DraftsTableTableUpdateCompanionBuilder,
          (
            DraftRow,
            BaseReferences<_$AppDatabase, $DraftsTableTable, DraftRow>,
          ),
          DraftRow,
          PrefetchHooks Function()
        > {
  $$DraftsTableTableTableManager(_$AppDatabase db, $DraftsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftsTableCompanion(
                key: key,
                payload: payload,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String payload,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DraftsTableCompanion.insert(
                key: key,
                payload: payload,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DraftsTableTable, DraftRow>(table),
                  BaseReferences<_$AppDatabase, $DraftsTableTable, DraftRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DraftsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftsTableTable,
      DraftRow,
      $$DraftsTableTableFilterComposer,
      $$DraftsTableTableOrderingComposer,
      $$DraftsTableTableAnnotationComposer,
      $$DraftsTableTableCreateCompanionBuilder,
      $$DraftsTableTableUpdateCompanionBuilder,
      (DraftRow, BaseReferences<_$AppDatabase, $DraftsTableTable, DraftRow>),
      DraftRow,
      PrefetchHooks Function()
    >;
typedef $$CacheEntriesTableTableCreateCompanionBuilder =
    CacheEntriesTableCompanion Function({
      required String key,
      required String payload,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CacheEntriesTableTableUpdateCompanionBuilder =
    CacheEntriesTableCompanion Function({
      Value<String> key,
      Value<String> payload,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CacheEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CacheEntriesTableTable> {
  $$CacheEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheEntriesTableTable> {
  $$CacheEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheEntriesTableTable> {
  $$CacheEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CacheEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheEntriesTableTable,
          CacheEntryRow,
          $$CacheEntriesTableTableFilterComposer,
          $$CacheEntriesTableTableOrderingComposer,
          $$CacheEntriesTableTableAnnotationComposer,
          $$CacheEntriesTableTableCreateCompanionBuilder,
          $$CacheEntriesTableTableUpdateCompanionBuilder,
          (
            CacheEntryRow,
            BaseReferences<
              _$AppDatabase,
              $CacheEntriesTableTable,
              CacheEntryRow
            >,
          ),
          CacheEntryRow,
          PrefetchHooks Function()
        > {
  $$CacheEntriesTableTableTableManager(
    _$AppDatabase db,
    $CacheEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheEntriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CacheEntriesTableCompanion(
                key: key,
                payload: payload,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String payload,
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CacheEntriesTableCompanion.insert(
                key: key,
                payload: payload,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CacheEntriesTableTable, CacheEntryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CacheEntriesTableTable,
                    CacheEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheEntriesTableTable,
      CacheEntryRow,
      $$CacheEntriesTableTableFilterComposer,
      $$CacheEntriesTableTableOrderingComposer,
      $$CacheEntriesTableTableAnnotationComposer,
      $$CacheEntriesTableTableCreateCompanionBuilder,
      $$CacheEntriesTableTableUpdateCompanionBuilder,
      (
        CacheEntryRow,
        BaseReferences<_$AppDatabase, $CacheEntriesTableTable, CacheEntryRow>,
      ),
      CacheEntryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DeviceSettingsTableTableTableManager get deviceSettingsTable =>
      $$DeviceSettingsTableTableTableManager(_db, _db.deviceSettingsTable);
  $$DraftsTableTableTableManager get draftsTable =>
      $$DraftsTableTableTableManager(_db, _db.draftsTable);
  $$CacheEntriesTableTableTableManager get cacheEntriesTable =>
      $$CacheEntriesTableTableTableManager(_db, _db.cacheEntriesTable);
}
