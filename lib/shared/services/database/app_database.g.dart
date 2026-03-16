// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, NoteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Untitled'),
  );
  static const VerificationMeta _contentDeltaJsonMeta = const VerificationMeta(
    'contentDeltaJson',
  );
  @override
  late final GeneratedColumn<String> contentDeltaJson = GeneratedColumn<String>(
    'content_delta_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _isPinnedMeta = const VerificationMeta(
    'isPinned',
  );
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    contentDeltaJson,
    tagsJson,
    isPinned,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<NoteRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('content_delta_json')) {
      context.handle(
        _contentDeltaJsonMeta,
        contentDeltaJson.isAcceptableOrUnknown(
          data['content_delta_json']!,
          _contentDeltaJsonMeta,
        ),
      );
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    }
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      contentDeltaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_delta_json'],
      )!,
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      )!,
      isPinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pinned'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteRecord extends DataClass implements Insertable<NoteRecord> {
  final int id;
  final String title;
  final String contentDeltaJson;
  final String tagsJson;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NoteRecord({
    required this.id,
    required this.title,
    required this.contentDeltaJson,
    required this.tagsJson,
    required this.isPinned,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content_delta_json'] = Variable<String>(contentDeltaJson);
    map['tags_json'] = Variable<String>(tagsJson);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      contentDeltaJson: Value(contentDeltaJson),
      tagsJson: Value(tagsJson),
      isPinned: Value(isPinned),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NoteRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteRecord(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      contentDeltaJson: serializer.fromJson<String>(json['contentDeltaJson']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'contentDeltaJson': serializer.toJson<String>(contentDeltaJson),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'isPinned': serializer.toJson<bool>(isPinned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NoteRecord copyWith({
    int? id,
    String? title,
    String? contentDeltaJson,
    String? tagsJson,
    bool? isPinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NoteRecord(
    id: id ?? this.id,
    title: title ?? this.title,
    contentDeltaJson: contentDeltaJson ?? this.contentDeltaJson,
    tagsJson: tagsJson ?? this.tagsJson,
    isPinned: isPinned ?? this.isPinned,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NoteRecord copyWithCompanion(NotesCompanion data) {
    return NoteRecord(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      contentDeltaJson: data.contentDeltaJson.present
          ? data.contentDeltaJson.value
          : this.contentDeltaJson,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteRecord(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('contentDeltaJson: $contentDeltaJson, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    contentDeltaJson,
    tagsJson,
    isPinned,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteRecord &&
          other.id == this.id &&
          other.title == this.title &&
          other.contentDeltaJson == this.contentDeltaJson &&
          other.tagsJson == this.tagsJson &&
          other.isPinned == this.isPinned &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<NoteRecord> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> contentDeltaJson;
  final Value<String> tagsJson;
  final Value<bool> isPinned;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.contentDeltaJson = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.contentDeltaJson = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<NoteRecord> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? contentDeltaJson,
    Expression<String>? tagsJson,
    Expression<bool>? isPinned,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (contentDeltaJson != null) 'content_delta_json': contentDeltaJson,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (isPinned != null) 'is_pinned': isPinned,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? contentDeltaJson,
    Value<String>? tagsJson,
    Value<bool>? isPinned,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      contentDeltaJson: contentDeltaJson ?? this.contentDeltaJson,
      tagsJson: tagsJson ?? this.tagsJson,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentDeltaJson.present) {
      map['content_delta_json'] = Variable<String>(contentDeltaJson.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('contentDeltaJson: $contentDeltaJson, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CalendarEventsTable extends CalendarEvents
    with TableInfo<$CalendarEventsTable, CalendarEventRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('New Event'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAllDayMeta = const VerificationMeta(
    'isAllDay',
  );
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
    'is_all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reminderMinutesMeta = const VerificationMeta(
    'reminderMinutes',
  );
  @override
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
    'reminder_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    startAt,
    endAt,
    isAllDay,
    reminderMinutes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarEventRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('is_all_day')) {
      context.handle(
        _isAllDayMeta,
        isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta),
      );
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
        _reminderMinutesMeta,
        reminderMinutes.isAcceptableOrUnknown(
          data['reminder_minutes']!,
          _reminderMinutesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalendarEventRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarEventRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      )!,
      isAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_all_day'],
      )!,
      reminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CalendarEventsTable createAlias(String alias) {
    return $CalendarEventsTable(attachedDatabase, alias);
  }
}

class CalendarEventRecord extends DataClass
    implements Insertable<CalendarEventRecord> {
  final int id;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime endAt;
  final bool isAllDay;
  final int? reminderMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CalendarEventRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.isAllDay,
    this.reminderMinutes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    map['is_all_day'] = Variable<bool>(isAllDay);
    if (!nullToAbsent || reminderMinutes != null) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CalendarEventsCompanion toCompanion(bool nullToAbsent) {
    return CalendarEventsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      startAt: Value(startAt),
      endAt: Value(endAt),
      isAllDay: Value(isAllDay),
      reminderMinutes: reminderMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CalendarEventRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarEventRecord(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
      reminderMinutes: serializer.fromJson<int?>(json['reminderMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'isAllDay': serializer.toJson<bool>(isAllDay),
      'reminderMinutes': serializer.toJson<int?>(reminderMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CalendarEventRecord copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? startAt,
    DateTime? endAt,
    bool? isAllDay,
    Value<int?> reminderMinutes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CalendarEventRecord(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    isAllDay: isAllDay ?? this.isAllDay,
    reminderMinutes: reminderMinutes.present
        ? reminderMinutes.value
        : this.reminderMinutes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CalendarEventRecord copyWithCompanion(CalendarEventsCompanion data) {
    return CalendarEventRecord(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEventRecord(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    startAt,
    endAt,
    isAllDay,
    reminderMinutes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarEventRecord &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.isAllDay == this.isAllDay &&
          other.reminderMinutes == this.reminderMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CalendarEventsCompanion extends UpdateCompanion<CalendarEventRecord> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<bool> isAllDay;
  final Value<int?> reminderMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CalendarEventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CalendarEventsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime startAt,
    required DateTime endAt,
    this.isAllDay = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : startAt = Value(startAt),
       endAt = Value(endAt);
  static Insertable<CalendarEventRecord> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<bool>? isAllDay,
    Expression<int>? reminderMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CalendarEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? startAt,
    Value<DateTime>? endAt,
    Value<bool>? isAllDay,
    Value<int?>? reminderMinutes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CalendarEventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      isAllDay: isAllDay ?? this.isAllDay,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarEventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, TodoRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _subtasksJsonMeta = const VerificationMeta(
    'subtasksJson',
  );
  @override
  late final GeneratedColumn<String> subtasksJson = GeneratedColumn<String>(
    'subtasks_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    priority,
    dueDate,
    isDone,
    subtasksJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    if (data.containsKey('subtasks_json')) {
      context.handle(
        _subtasksJsonMeta,
        subtasksJson.isAcceptableOrUnknown(
          data['subtasks_json']!,
          _subtasksJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      subtasksJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtasks_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class TodoRecord extends DataClass implements Insertable<TodoRecord> {
  final String id;
  final String title;
  final int priority;
  final DateTime? dueDate;
  final bool isDone;
  final String subtasksJson;
  final DateTime createdAt;
  const TodoRecord({
    required this.id,
    required this.title,
    required this.priority,
    this.dueDate,
    required this.isDone,
    required this.subtasksJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['is_done'] = Variable<bool>(isDone);
    map['subtasks_json'] = Variable<String>(subtasksJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      priority: Value(priority),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isDone: Value(isDone),
      subtasksJson: Value(subtasksJson),
      createdAt: Value(createdAt),
    );
  }

  factory TodoRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoRecord(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      priority: serializer.fromJson<int>(json['priority']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      subtasksJson: serializer.fromJson<String>(json['subtasksJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'priority': serializer.toJson<int>(priority),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'isDone': serializer.toJson<bool>(isDone),
      'subtasksJson': serializer.toJson<String>(subtasksJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TodoRecord copyWith({
    String? id,
    String? title,
    int? priority,
    Value<DateTime?> dueDate = const Value.absent(),
    bool? isDone,
    String? subtasksJson,
    DateTime? createdAt,
  }) => TodoRecord(
    id: id ?? this.id,
    title: title ?? this.title,
    priority: priority ?? this.priority,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    isDone: isDone ?? this.isDone,
    subtasksJson: subtasksJson ?? this.subtasksJson,
    createdAt: createdAt ?? this.createdAt,
  );
  TodoRecord copyWithCompanion(TodosCompanion data) {
    return TodoRecord(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      priority: data.priority.present ? data.priority.value : this.priority,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      subtasksJson: data.subtasksJson.present
          ? data.subtasksJson.value
          : this.subtasksJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoRecord(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate, ')
          ..write('isDone: $isDone, ')
          ..write('subtasksJson: $subtasksJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    priority,
    dueDate,
    isDone,
    subtasksJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoRecord &&
          other.id == this.id &&
          other.title == this.title &&
          other.priority == this.priority &&
          other.dueDate == this.dueDate &&
          other.isDone == this.isDone &&
          other.subtasksJson == this.subtasksJson &&
          other.createdAt == this.createdAt);
}

class TodosCompanion extends UpdateCompanion<TodoRecord> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> priority;
  final Value<DateTime?> dueDate;
  final Value<bool> isDone;
  final Value<String> subtasksJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.priority = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.subtasksJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodosCompanion.insert({
    required String id,
    required String title,
    this.priority = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.subtasksJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<TodoRecord> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? priority,
    Expression<DateTime>? dueDate,
    Expression<bool>? isDone,
    Expression<String>? subtasksJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (priority != null) 'priority': priority,
      if (dueDate != null) 'due_date': dueDate,
      if (isDone != null) 'is_done': isDone,
      if (subtasksJson != null) 'subtasks_json': subtasksJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodosCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? priority,
    Value<DateTime?>? dueDate,
    Value<bool>? isDone,
    Value<String>? subtasksJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      subtasksJson: subtasksJson ?? this.subtasksJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (subtasksJson.present) {
      map['subtasks_json'] = Variable<String>(subtasksJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate, ')
          ..write('isDone: $isDone, ')
          ..write('subtasksJson: $subtasksJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetPerWeekMeta = const VerificationMeta(
    'targetPerWeek',
  );
  @override
  late final GeneratedColumn<int> targetPerWeek = GeneratedColumn<int>(
    'target_per_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _completedDaysJsonMeta = const VerificationMeta(
    'completedDaysJson',
  );
  @override
  late final GeneratedColumn<String> completedDaysJson =
      GeneratedColumn<String>(
        'completed_days_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    targetPerWeek,
    completedDaysJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_per_week')) {
      context.handle(
        _targetPerWeekMeta,
        targetPerWeek.isAcceptableOrUnknown(
          data['target_per_week']!,
          _targetPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('completed_days_json')) {
      context.handle(
        _completedDaysJsonMeta,
        completedDaysJson.isAcceptableOrUnknown(
          data['completed_days_json']!,
          _completedDaysJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_per_week'],
      )!,
      completedDaysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_days_json'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class HabitRecord extends DataClass implements Insertable<HabitRecord> {
  final String id;
  final String title;
  final int targetPerWeek;
  final String completedDaysJson;
  const HabitRecord({
    required this.id,
    required this.title,
    required this.targetPerWeek,
    required this.completedDaysJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['target_per_week'] = Variable<int>(targetPerWeek);
    map['completed_days_json'] = Variable<String>(completedDaysJson);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      targetPerWeek: Value(targetPerWeek),
      completedDaysJson: Value(completedDaysJson),
    );
  }

  factory HabitRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRecord(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      targetPerWeek: serializer.fromJson<int>(json['targetPerWeek']),
      completedDaysJson: serializer.fromJson<String>(json['completedDaysJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'targetPerWeek': serializer.toJson<int>(targetPerWeek),
      'completedDaysJson': serializer.toJson<String>(completedDaysJson),
    };
  }

  HabitRecord copyWith({
    String? id,
    String? title,
    int? targetPerWeek,
    String? completedDaysJson,
  }) => HabitRecord(
    id: id ?? this.id,
    title: title ?? this.title,
    targetPerWeek: targetPerWeek ?? this.targetPerWeek,
    completedDaysJson: completedDaysJson ?? this.completedDaysJson,
  );
  HabitRecord copyWithCompanion(HabitsCompanion data) {
    return HabitRecord(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      targetPerWeek: data.targetPerWeek.present
          ? data.targetPerWeek.value
          : this.targetPerWeek,
      completedDaysJson: data.completedDaysJson.present
          ? data.completedDaysJson.value
          : this.completedDaysJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRecord(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetPerWeek: $targetPerWeek, ')
          ..write('completedDaysJson: $completedDaysJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, targetPerWeek, completedDaysJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRecord &&
          other.id == this.id &&
          other.title == this.title &&
          other.targetPerWeek == this.targetPerWeek &&
          other.completedDaysJson == this.completedDaysJson);
}

class HabitsCompanion extends UpdateCompanion<HabitRecord> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> targetPerWeek;
  final Value<String> completedDaysJson;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.targetPerWeek = const Value.absent(),
    this.completedDaysJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    this.targetPerWeek = const Value.absent(),
    this.completedDaysJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<HabitRecord> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? targetPerWeek,
    Expression<String>? completedDaysJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (targetPerWeek != null) 'target_per_week': targetPerWeek,
      if (completedDaysJson != null) 'completed_days_json': completedDaysJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? targetPerWeek,
    Value<String>? completedDaysJson,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      targetPerWeek: targetPerWeek ?? this.targetPerWeek,
      completedDaysJson: completedDaysJson ?? this.completedDaysJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetPerWeek.present) {
      map['target_per_week'] = Variable<int>(targetPerWeek.value);
    }
    if (completedDaysJson.present) {
      map['completed_days_json'] = Variable<String>(completedDaysJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetPerWeek: $targetPerWeek, ')
          ..write('completedDaysJson: $completedDaysJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PomodoroStatsTable extends PomodoroStats
    with TableInfo<$PomodoroStatsTable, PomodoroStatsRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PomodoroStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedFocusSessionsMeta =
      const VerificationMeta('completedFocusSessions');
  @override
  late final GeneratedColumn<int> completedFocusSessions = GeneratedColumn<int>(
    'completed_focus_sessions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalFocusSecondsMeta = const VerificationMeta(
    'totalFocusSeconds',
  );
  @override
  late final GeneratedColumn<int> totalFocusSeconds = GeneratedColumn<int>(
    'total_focus_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cyclesMeta = const VerificationMeta('cycles');
  @override
  late final GeneratedColumn<int> cycles = GeneratedColumn<int>(
    'cycles',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _focusMinutesMeta = const VerificationMeta(
    'focusMinutes',
  );
  @override
  late final GeneratedColumn<int> focusMinutes = GeneratedColumn<int>(
    'focus_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    completedFocusSessions,
    totalFocusSeconds,
    cycles,
    focusMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pomodoro_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<PomodoroStatsRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('completed_focus_sessions')) {
      context.handle(
        _completedFocusSessionsMeta,
        completedFocusSessions.isAcceptableOrUnknown(
          data['completed_focus_sessions']!,
          _completedFocusSessionsMeta,
        ),
      );
    }
    if (data.containsKey('total_focus_seconds')) {
      context.handle(
        _totalFocusSecondsMeta,
        totalFocusSeconds.isAcceptableOrUnknown(
          data['total_focus_seconds']!,
          _totalFocusSecondsMeta,
        ),
      );
    }
    if (data.containsKey('cycles')) {
      context.handle(
        _cyclesMeta,
        cycles.isAcceptableOrUnknown(data['cycles']!, _cyclesMeta),
      );
    }
    if (data.containsKey('focus_minutes')) {
      context.handle(
        _focusMinutesMeta,
        focusMinutes.isAcceptableOrUnknown(
          data['focus_minutes']!,
          _focusMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PomodoroStatsRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PomodoroStatsRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      completedFocusSessions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_focus_sessions'],
      )!,
      totalFocusSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_focus_seconds'],
      )!,
      cycles: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycles'],
      )!,
      focusMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_minutes'],
      )!,
    );
  }

  @override
  $PomodoroStatsTable createAlias(String alias) {
    return $PomodoroStatsTable(attachedDatabase, alias);
  }
}

class PomodoroStatsRecord extends DataClass
    implements Insertable<PomodoroStatsRecord> {
  final int id;
  final int completedFocusSessions;
  final int totalFocusSeconds;
  final int cycles;
  final int focusMinutes;
  const PomodoroStatsRecord({
    required this.id,
    required this.completedFocusSessions,
    required this.totalFocusSeconds,
    required this.cycles,
    required this.focusMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['completed_focus_sessions'] = Variable<int>(completedFocusSessions);
    map['total_focus_seconds'] = Variable<int>(totalFocusSeconds);
    map['cycles'] = Variable<int>(cycles);
    map['focus_minutes'] = Variable<int>(focusMinutes);
    return map;
  }

  PomodoroStatsCompanion toCompanion(bool nullToAbsent) {
    return PomodoroStatsCompanion(
      id: Value(id),
      completedFocusSessions: Value(completedFocusSessions),
      totalFocusSeconds: Value(totalFocusSeconds),
      cycles: Value(cycles),
      focusMinutes: Value(focusMinutes),
    );
  }

  factory PomodoroStatsRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PomodoroStatsRecord(
      id: serializer.fromJson<int>(json['id']),
      completedFocusSessions: serializer.fromJson<int>(
        json['completedFocusSessions'],
      ),
      totalFocusSeconds: serializer.fromJson<int>(json['totalFocusSeconds']),
      cycles: serializer.fromJson<int>(json['cycles']),
      focusMinutes: serializer.fromJson<int>(json['focusMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'completedFocusSessions': serializer.toJson<int>(completedFocusSessions),
      'totalFocusSeconds': serializer.toJson<int>(totalFocusSeconds),
      'cycles': serializer.toJson<int>(cycles),
      'focusMinutes': serializer.toJson<int>(focusMinutes),
    };
  }

  PomodoroStatsRecord copyWith({
    int? id,
    int? completedFocusSessions,
    int? totalFocusSeconds,
    int? cycles,
    int? focusMinutes,
  }) => PomodoroStatsRecord(
    id: id ?? this.id,
    completedFocusSessions:
        completedFocusSessions ?? this.completedFocusSessions,
    totalFocusSeconds: totalFocusSeconds ?? this.totalFocusSeconds,
    cycles: cycles ?? this.cycles,
    focusMinutes: focusMinutes ?? this.focusMinutes,
  );
  PomodoroStatsRecord copyWithCompanion(PomodoroStatsCompanion data) {
    return PomodoroStatsRecord(
      id: data.id.present ? data.id.value : this.id,
      completedFocusSessions: data.completedFocusSessions.present
          ? data.completedFocusSessions.value
          : this.completedFocusSessions,
      totalFocusSeconds: data.totalFocusSeconds.present
          ? data.totalFocusSeconds.value
          : this.totalFocusSeconds,
      cycles: data.cycles.present ? data.cycles.value : this.cycles,
      focusMinutes: data.focusMinutes.present
          ? data.focusMinutes.value
          : this.focusMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PomodoroStatsRecord(')
          ..write('id: $id, ')
          ..write('completedFocusSessions: $completedFocusSessions, ')
          ..write('totalFocusSeconds: $totalFocusSeconds, ')
          ..write('cycles: $cycles, ')
          ..write('focusMinutes: $focusMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    completedFocusSessions,
    totalFocusSeconds,
    cycles,
    focusMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PomodoroStatsRecord &&
          other.id == this.id &&
          other.completedFocusSessions == this.completedFocusSessions &&
          other.totalFocusSeconds == this.totalFocusSeconds &&
          other.cycles == this.cycles &&
          other.focusMinutes == this.focusMinutes);
}

class PomodoroStatsCompanion extends UpdateCompanion<PomodoroStatsRecord> {
  final Value<int> id;
  final Value<int> completedFocusSessions;
  final Value<int> totalFocusSeconds;
  final Value<int> cycles;
  final Value<int> focusMinutes;
  const PomodoroStatsCompanion({
    this.id = const Value.absent(),
    this.completedFocusSessions = const Value.absent(),
    this.totalFocusSeconds = const Value.absent(),
    this.cycles = const Value.absent(),
    this.focusMinutes = const Value.absent(),
  });
  PomodoroStatsCompanion.insert({
    this.id = const Value.absent(),
    this.completedFocusSessions = const Value.absent(),
    this.totalFocusSeconds = const Value.absent(),
    this.cycles = const Value.absent(),
    this.focusMinutes = const Value.absent(),
  });
  static Insertable<PomodoroStatsRecord> custom({
    Expression<int>? id,
    Expression<int>? completedFocusSessions,
    Expression<int>? totalFocusSeconds,
    Expression<int>? cycles,
    Expression<int>? focusMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (completedFocusSessions != null)
        'completed_focus_sessions': completedFocusSessions,
      if (totalFocusSeconds != null) 'total_focus_seconds': totalFocusSeconds,
      if (cycles != null) 'cycles': cycles,
      if (focusMinutes != null) 'focus_minutes': focusMinutes,
    });
  }

  PomodoroStatsCompanion copyWith({
    Value<int>? id,
    Value<int>? completedFocusSessions,
    Value<int>? totalFocusSeconds,
    Value<int>? cycles,
    Value<int>? focusMinutes,
  }) {
    return PomodoroStatsCompanion(
      id: id ?? this.id,
      completedFocusSessions:
          completedFocusSessions ?? this.completedFocusSessions,
      totalFocusSeconds: totalFocusSeconds ?? this.totalFocusSeconds,
      cycles: cycles ?? this.cycles,
      focusMinutes: focusMinutes ?? this.focusMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (completedFocusSessions.present) {
      map['completed_focus_sessions'] = Variable<int>(
        completedFocusSessions.value,
      );
    }
    if (totalFocusSeconds.present) {
      map['total_focus_seconds'] = Variable<int>(totalFocusSeconds.value);
    }
    if (cycles.present) {
      map['cycles'] = Variable<int>(cycles.value);
    }
    if (focusMinutes.present) {
      map['focus_minutes'] = Variable<int>(focusMinutes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PomodoroStatsCompanion(')
          ..write('id: $id, ')
          ..write('completedFocusSessions: $completedFocusSessions, ')
          ..write('totalFocusSeconds: $totalFocusSeconds, ')
          ..write('cycles: $cycles, ')
          ..write('focusMinutes: $focusMinutes')
          ..write(')'))
        .toString();
  }
}

class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, AlarmRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Alarm'),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _recurringWeekdaysJsonMeta =
      const VerificationMeta('recurringWeekdaysJson');
  @override
  late final GeneratedColumn<String> recurringWeekdaysJson =
      GeneratedColumn<String>(
        'recurring_weekdays_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _snoozeMinutesMeta = const VerificationMeta(
    'snoozeMinutes',
  );
  @override
  late final GeneratedColumn<int> snoozeMinutes = GeneratedColumn<int>(
    'snooze_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _vibrationMeta = const VerificationMeta(
    'vibration',
  );
  @override
  late final GeneratedColumn<bool> vibration = GeneratedColumn<bool>(
    'vibration',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("vibration" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _soundMeta = const VerificationMeta('sound');
  @override
  late final GeneratedColumn<bool> sound = GeneratedColumn<bool>(
    'sound',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hour,
    minute,
    label,
    enabled,
    recurringWeekdaysJson,
    snoozeMinutes,
    vibration,
    sound,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlarmRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('recurring_weekdays_json')) {
      context.handle(
        _recurringWeekdaysJsonMeta,
        recurringWeekdaysJson.isAcceptableOrUnknown(
          data['recurring_weekdays_json']!,
          _recurringWeekdaysJsonMeta,
        ),
      );
    }
    if (data.containsKey('snooze_minutes')) {
      context.handle(
        _snoozeMinutesMeta,
        snoozeMinutes.isAcceptableOrUnknown(
          data['snooze_minutes']!,
          _snoozeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('vibration')) {
      context.handle(
        _vibrationMeta,
        vibration.isAcceptableOrUnknown(data['vibration']!, _vibrationMeta),
      );
    }
    if (data.containsKey('sound')) {
      context.handle(
        _soundMeta,
        sound.isAcceptableOrUnknown(data['sound']!, _soundMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      recurringWeekdaysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurring_weekdays_json'],
      )!,
      snoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_minutes'],
      )!,
      vibration: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vibration'],
      )!,
      sound: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound'],
      )!,
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }
}

class AlarmRecord extends DataClass implements Insertable<AlarmRecord> {
  final int id;
  final int hour;
  final int minute;
  final String label;
  final bool enabled;
  final String recurringWeekdaysJson;
  final int snoozeMinutes;
  final bool vibration;
  final bool sound;
  const AlarmRecord({
    required this.id,
    required this.hour,
    required this.minute,
    required this.label,
    required this.enabled,
    required this.recurringWeekdaysJson,
    required this.snoozeMinutes,
    required this.vibration,
    required this.sound,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['label'] = Variable<String>(label);
    map['enabled'] = Variable<bool>(enabled);
    map['recurring_weekdays_json'] = Variable<String>(recurringWeekdaysJson);
    map['snooze_minutes'] = Variable<int>(snoozeMinutes);
    map['vibration'] = Variable<bool>(vibration);
    map['sound'] = Variable<bool>(sound);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      hour: Value(hour),
      minute: Value(minute),
      label: Value(label),
      enabled: Value(enabled),
      recurringWeekdaysJson: Value(recurringWeekdaysJson),
      snoozeMinutes: Value(snoozeMinutes),
      vibration: Value(vibration),
      sound: Value(sound),
    );
  }

  factory AlarmRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmRecord(
      id: serializer.fromJson<int>(json['id']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      label: serializer.fromJson<String>(json['label']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      recurringWeekdaysJson: serializer.fromJson<String>(
        json['recurringWeekdaysJson'],
      ),
      snoozeMinutes: serializer.fromJson<int>(json['snoozeMinutes']),
      vibration: serializer.fromJson<bool>(json['vibration']),
      sound: serializer.fromJson<bool>(json['sound']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'label': serializer.toJson<String>(label),
      'enabled': serializer.toJson<bool>(enabled),
      'recurringWeekdaysJson': serializer.toJson<String>(recurringWeekdaysJson),
      'snoozeMinutes': serializer.toJson<int>(snoozeMinutes),
      'vibration': serializer.toJson<bool>(vibration),
      'sound': serializer.toJson<bool>(sound),
    };
  }

  AlarmRecord copyWith({
    int? id,
    int? hour,
    int? minute,
    String? label,
    bool? enabled,
    String? recurringWeekdaysJson,
    int? snoozeMinutes,
    bool? vibration,
    bool? sound,
  }) => AlarmRecord(
    id: id ?? this.id,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    label: label ?? this.label,
    enabled: enabled ?? this.enabled,
    recurringWeekdaysJson: recurringWeekdaysJson ?? this.recurringWeekdaysJson,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    vibration: vibration ?? this.vibration,
    sound: sound ?? this.sound,
  );
  AlarmRecord copyWithCompanion(AlarmsCompanion data) {
    return AlarmRecord(
      id: data.id.present ? data.id.value : this.id,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      label: data.label.present ? data.label.value : this.label,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      recurringWeekdaysJson: data.recurringWeekdaysJson.present
          ? data.recurringWeekdaysJson.value
          : this.recurringWeekdaysJson,
      snoozeMinutes: data.snoozeMinutes.present
          ? data.snoozeMinutes.value
          : this.snoozeMinutes,
      vibration: data.vibration.present ? data.vibration.value : this.vibration,
      sound: data.sound.present ? data.sound.value : this.sound,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmRecord(')
          ..write('id: $id, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('label: $label, ')
          ..write('enabled: $enabled, ')
          ..write('recurringWeekdaysJson: $recurringWeekdaysJson, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('vibration: $vibration, ')
          ..write('sound: $sound')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hour,
    minute,
    label,
    enabled,
    recurringWeekdaysJson,
    snoozeMinutes,
    vibration,
    sound,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmRecord &&
          other.id == this.id &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.label == this.label &&
          other.enabled == this.enabled &&
          other.recurringWeekdaysJson == this.recurringWeekdaysJson &&
          other.snoozeMinutes == this.snoozeMinutes &&
          other.vibration == this.vibration &&
          other.sound == this.sound);
}

class AlarmsCompanion extends UpdateCompanion<AlarmRecord> {
  final Value<int> id;
  final Value<int> hour;
  final Value<int> minute;
  final Value<String> label;
  final Value<bool> enabled;
  final Value<String> recurringWeekdaysJson;
  final Value<int> snoozeMinutes;
  final Value<bool> vibration;
  final Value<bool> sound;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.label = const Value.absent(),
    this.enabled = const Value.absent(),
    this.recurringWeekdaysJson = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.vibration = const Value.absent(),
    this.sound = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    required int hour,
    required int minute,
    this.label = const Value.absent(),
    this.enabled = const Value.absent(),
    this.recurringWeekdaysJson = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.vibration = const Value.absent(),
    this.sound = const Value.absent(),
  }) : hour = Value(hour),
       minute = Value(minute);
  static Insertable<AlarmRecord> custom({
    Expression<int>? id,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<String>? label,
    Expression<bool>? enabled,
    Expression<String>? recurringWeekdaysJson,
    Expression<int>? snoozeMinutes,
    Expression<bool>? vibration,
    Expression<bool>? sound,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (label != null) 'label': label,
      if (enabled != null) 'enabled': enabled,
      if (recurringWeekdaysJson != null)
        'recurring_weekdays_json': recurringWeekdaysJson,
      if (snoozeMinutes != null) 'snooze_minutes': snoozeMinutes,
      if (vibration != null) 'vibration': vibration,
      if (sound != null) 'sound': sound,
    });
  }

  AlarmsCompanion copyWith({
    Value<int>? id,
    Value<int>? hour,
    Value<int>? minute,
    Value<String>? label,
    Value<bool>? enabled,
    Value<String>? recurringWeekdaysJson,
    Value<int>? snoozeMinutes,
    Value<bool>? vibration,
    Value<bool>? sound,
  }) {
    return AlarmsCompanion(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      recurringWeekdaysJson:
          recurringWeekdaysJson ?? this.recurringWeekdaysJson,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      vibration: vibration ?? this.vibration,
      sound: sound ?? this.sound,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (recurringWeekdaysJson.present) {
      map['recurring_weekdays_json'] = Variable<String>(
        recurringWeekdaysJson.value,
      );
    }
    if (snoozeMinutes.present) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes.value);
    }
    if (vibration.present) {
      map['vibration'] = Variable<bool>(vibration.value);
    }
    if (sound.present) {
      map['sound'] = Variable<bool>(sound.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('label: $label, ')
          ..write('enabled: $enabled, ')
          ..write('recurringWeekdaysJson: $recurringWeekdaysJson, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('vibration: $vibration, ')
          ..write('sound: $sound')
          ..write(')'))
        .toString();
  }
}

class $VoiceMemosTable extends VoiceMemos
    with TableInfo<$VoiceMemosTable, VoiceMemoRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VoiceMemosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transcriptMeta = const VerificationMeta(
    'transcript',
  );
  @override
  late final GeneratedColumn<String> transcript = GeneratedColumn<String>(
    'transcript',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, transcript, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'voice_memos';
  @override
  VerificationContext validateIntegrity(
    Insertable<VoiceMemoRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('transcript')) {
      context.handle(
        _transcriptMeta,
        transcript.isAcceptableOrUnknown(data['transcript']!, _transcriptMeta),
      );
    } else if (isInserting) {
      context.missing(_transcriptMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VoiceMemoRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VoiceMemoRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      transcript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transcript'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VoiceMemosTable createAlias(String alias) {
    return $VoiceMemosTable(attachedDatabase, alias);
  }
}

class VoiceMemoRecord extends DataClass implements Insertable<VoiceMemoRecord> {
  final String id;
  final String transcript;
  final DateTime createdAt;
  const VoiceMemoRecord({
    required this.id,
    required this.transcript,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['transcript'] = Variable<String>(transcript);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VoiceMemosCompanion toCompanion(bool nullToAbsent) {
    return VoiceMemosCompanion(
      id: Value(id),
      transcript: Value(transcript),
      createdAt: Value(createdAt),
    );
  }

  factory VoiceMemoRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VoiceMemoRecord(
      id: serializer.fromJson<String>(json['id']),
      transcript: serializer.fromJson<String>(json['transcript']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'transcript': serializer.toJson<String>(transcript),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VoiceMemoRecord copyWith({
    String? id,
    String? transcript,
    DateTime? createdAt,
  }) => VoiceMemoRecord(
    id: id ?? this.id,
    transcript: transcript ?? this.transcript,
    createdAt: createdAt ?? this.createdAt,
  );
  VoiceMemoRecord copyWithCompanion(VoiceMemosCompanion data) {
    return VoiceMemoRecord(
      id: data.id.present ? data.id.value : this.id,
      transcript: data.transcript.present
          ? data.transcript.value
          : this.transcript,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VoiceMemoRecord(')
          ..write('id: $id, ')
          ..write('transcript: $transcript, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, transcript, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoiceMemoRecord &&
          other.id == this.id &&
          other.transcript == this.transcript &&
          other.createdAt == this.createdAt);
}

class VoiceMemosCompanion extends UpdateCompanion<VoiceMemoRecord> {
  final Value<String> id;
  final Value<String> transcript;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const VoiceMemosCompanion({
    this.id = const Value.absent(),
    this.transcript = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VoiceMemosCompanion.insert({
    required String id,
    required String transcript,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       transcript = Value(transcript);
  static Insertable<VoiceMemoRecord> custom({
    Expression<String>? id,
    Expression<String>? transcript,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transcript != null) 'transcript': transcript,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VoiceMemosCompanion copyWith({
    Value<String>? id,
    Value<String>? transcript,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return VoiceMemosCompanion(
      id: id ?? this.id,
      transcript: transcript ?? this.transcript,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (transcript.present) {
      map['transcript'] = Variable<String>(transcript.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VoiceMemosCompanion(')
          ..write('id: $id, ')
          ..write('transcript: $transcript, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalculatorPrefsTable extends CalculatorPrefs
    with TableInfo<$CalculatorPrefsTable, CalculatorPrefRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalculatorPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputMeta = const VerificationMeta('input');
  @override
  late final GeneratedColumn<String> input = GeneratedColumn<String>(
    'input',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _outputMeta = const VerificationMeta('output');
  @override
  late final GeneratedColumn<String> output = GeneratedColumn<String>(
    'output',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('0'),
  );
  static const VerificationMeta _memoryMeta = const VerificationMeta('memory');
  @override
  late final GeneratedColumn<double> memory = GeneratedColumn<double>(
    'memory',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, input, output, memory];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calculator_prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalculatorPrefRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('input')) {
      context.handle(
        _inputMeta,
        input.isAcceptableOrUnknown(data['input']!, _inputMeta),
      );
    }
    if (data.containsKey('output')) {
      context.handle(
        _outputMeta,
        output.isAcceptableOrUnknown(data['output']!, _outputMeta),
      );
    }
    if (data.containsKey('memory')) {
      context.handle(
        _memoryMeta,
        memory.isAcceptableOrUnknown(data['memory']!, _memoryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalculatorPrefRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalculatorPrefRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      input: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input'],
      )!,
      output: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}output'],
      )!,
      memory: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}memory'],
      )!,
    );
  }

  @override
  $CalculatorPrefsTable createAlias(String alias) {
    return $CalculatorPrefsTable(attachedDatabase, alias);
  }
}

class CalculatorPrefRecord extends DataClass
    implements Insertable<CalculatorPrefRecord> {
  final int id;
  final String input;
  final String output;
  final double memory;
  const CalculatorPrefRecord({
    required this.id,
    required this.input,
    required this.output,
    required this.memory,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['input'] = Variable<String>(input);
    map['output'] = Variable<String>(output);
    map['memory'] = Variable<double>(memory);
    return map;
  }

  CalculatorPrefsCompanion toCompanion(bool nullToAbsent) {
    return CalculatorPrefsCompanion(
      id: Value(id),
      input: Value(input),
      output: Value(output),
      memory: Value(memory),
    );
  }

  factory CalculatorPrefRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalculatorPrefRecord(
      id: serializer.fromJson<int>(json['id']),
      input: serializer.fromJson<String>(json['input']),
      output: serializer.fromJson<String>(json['output']),
      memory: serializer.fromJson<double>(json['memory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'input': serializer.toJson<String>(input),
      'output': serializer.toJson<String>(output),
      'memory': serializer.toJson<double>(memory),
    };
  }

  CalculatorPrefRecord copyWith({
    int? id,
    String? input,
    String? output,
    double? memory,
  }) => CalculatorPrefRecord(
    id: id ?? this.id,
    input: input ?? this.input,
    output: output ?? this.output,
    memory: memory ?? this.memory,
  );
  CalculatorPrefRecord copyWithCompanion(CalculatorPrefsCompanion data) {
    return CalculatorPrefRecord(
      id: data.id.present ? data.id.value : this.id,
      input: data.input.present ? data.input.value : this.input,
      output: data.output.present ? data.output.value : this.output,
      memory: data.memory.present ? data.memory.value : this.memory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalculatorPrefRecord(')
          ..write('id: $id, ')
          ..write('input: $input, ')
          ..write('output: $output, ')
          ..write('memory: $memory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, input, output, memory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalculatorPrefRecord &&
          other.id == this.id &&
          other.input == this.input &&
          other.output == this.output &&
          other.memory == this.memory);
}

class CalculatorPrefsCompanion extends UpdateCompanion<CalculatorPrefRecord> {
  final Value<int> id;
  final Value<String> input;
  final Value<String> output;
  final Value<double> memory;
  const CalculatorPrefsCompanion({
    this.id = const Value.absent(),
    this.input = const Value.absent(),
    this.output = const Value.absent(),
    this.memory = const Value.absent(),
  });
  CalculatorPrefsCompanion.insert({
    this.id = const Value.absent(),
    this.input = const Value.absent(),
    this.output = const Value.absent(),
    this.memory = const Value.absent(),
  });
  static Insertable<CalculatorPrefRecord> custom({
    Expression<int>? id,
    Expression<String>? input,
    Expression<String>? output,
    Expression<double>? memory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (input != null) 'input': input,
      if (output != null) 'output': output,
      if (memory != null) 'memory': memory,
    });
  }

  CalculatorPrefsCompanion copyWith({
    Value<int>? id,
    Value<String>? input,
    Value<String>? output,
    Value<double>? memory,
  }) {
    return CalculatorPrefsCompanion(
      id: id ?? this.id,
      input: input ?? this.input,
      output: output ?? this.output,
      memory: memory ?? this.memory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (input.present) {
      map['input'] = Variable<String>(input.value);
    }
    if (output.present) {
      map['output'] = Variable<String>(output.value);
    }
    if (memory.present) {
      map['memory'] = Variable<double>(memory.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalculatorPrefsCompanion(')
          ..write('id: $id, ')
          ..write('input: $input, ')
          ..write('output: $output, ')
          ..write('memory: $memory')
          ..write(')'))
        .toString();
  }
}

class $CalculatorHistoryTable extends CalculatorHistory
    with TableInfo<$CalculatorHistoryTable, CalculatorHistoryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalculatorHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<String> item = GeneratedColumn<String>(
    'item',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, item, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calculator_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalculatorHistoryRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalculatorHistoryRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalculatorHistoryRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CalculatorHistoryTable createAlias(String alias) {
    return $CalculatorHistoryTable(attachedDatabase, alias);
  }
}

class CalculatorHistoryRecord extends DataClass
    implements Insertable<CalculatorHistoryRecord> {
  final int id;
  final String item;
  final DateTime createdAt;
  const CalculatorHistoryRecord({
    required this.id,
    required this.item,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item'] = Variable<String>(item);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CalculatorHistoryCompanion toCompanion(bool nullToAbsent) {
    return CalculatorHistoryCompanion(
      id: Value(id),
      item: Value(item),
      createdAt: Value(createdAt),
    );
  }

  factory CalculatorHistoryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalculatorHistoryRecord(
      id: serializer.fromJson<int>(json['id']),
      item: serializer.fromJson<String>(json['item']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'item': serializer.toJson<String>(item),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CalculatorHistoryRecord copyWith({
    int? id,
    String? item,
    DateTime? createdAt,
  }) => CalculatorHistoryRecord(
    id: id ?? this.id,
    item: item ?? this.item,
    createdAt: createdAt ?? this.createdAt,
  );
  CalculatorHistoryRecord copyWithCompanion(CalculatorHistoryCompanion data) {
    return CalculatorHistoryRecord(
      id: data.id.present ? data.id.value : this.id,
      item: data.item.present ? data.item.value : this.item,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalculatorHistoryRecord(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, item, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalculatorHistoryRecord &&
          other.id == this.id &&
          other.item == this.item &&
          other.createdAt == this.createdAt);
}

class CalculatorHistoryCompanion
    extends UpdateCompanion<CalculatorHistoryRecord> {
  final Value<int> id;
  final Value<String> item;
  final Value<DateTime> createdAt;
  const CalculatorHistoryCompanion({
    this.id = const Value.absent(),
    this.item = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CalculatorHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String item,
    this.createdAt = const Value.absent(),
  }) : item = Value(item);
  static Insertable<CalculatorHistoryRecord> custom({
    Expression<int>? id,
    Expression<String>? item,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (item != null) 'item': item,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CalculatorHistoryCompanion copyWith({
    Value<int>? id,
    Value<String>? item,
    Value<DateTime>? createdAt,
  }) {
    return CalculatorHistoryCompanion(
      id: id ?? this.id,
      item: item ?? this.item,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (item.present) {
      map['item'] = Variable<String>(item.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalculatorHistoryCompanion(')
          ..write('id: $id, ')
          ..write('item: $item, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $CalendarEventsTable calendarEvents = $CalendarEventsTable(this);
  late final $TodosTable todos = $TodosTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $PomodoroStatsTable pomodoroStats = $PomodoroStatsTable(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $VoiceMemosTable voiceMemos = $VoiceMemosTable(this);
  late final $CalculatorPrefsTable calculatorPrefs = $CalculatorPrefsTable(
    this,
  );
  late final $CalculatorHistoryTable calculatorHistory =
      $CalculatorHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    notes,
    calendarEvents,
    todos,
    habits,
    pomodoroStats,
    alarms,
    voiceMemos,
    calculatorPrefs,
    calculatorHistory,
  ];
}

typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> contentDeltaJson,
      Value<String> tagsJson,
      Value<bool> isPinned,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> contentDeltaJson,
      Value<String> tagsJson,
      Value<bool> isPinned,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentDeltaJson => $composableBuilder(
    column: $table.contentDeltaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentDeltaJson => $composableBuilder(
    column: $table.contentDeltaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentDeltaJson => $composableBuilder(
    column: $table.contentDeltaJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          NoteRecord,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (NoteRecord, BaseReferences<_$AppDatabase, $NotesTable, NoteRecord>),
          NoteRecord,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> contentDeltaJson = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                title: title,
                contentDeltaJson: contentDeltaJson,
                tagsJson: tagsJson,
                isPinned: isPinned,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> contentDeltaJson = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                title: title,
                contentDeltaJson: contentDeltaJson,
                tagsJson: tagsJson,
                isPinned: isPinned,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      NoteRecord,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (NoteRecord, BaseReferences<_$AppDatabase, $NotesTable, NoteRecord>),
      NoteRecord,
      PrefetchHooks Function()
    >;
typedef $$CalendarEventsTableCreateCompanionBuilder =
    CalendarEventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      required DateTime startAt,
      required DateTime endAt,
      Value<bool> isAllDay,
      Value<int?> reminderMinutes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CalendarEventsTableUpdateCompanionBuilder =
    CalendarEventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime> startAt,
      Value<DateTime> endAt,
      Value<bool> isAllDay,
      Value<int?> reminderMinutes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$CalendarEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAllDay => $composableBuilder(
    column: $table.isAllDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarEventsTable> {
  $$CalendarEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<bool> get isAllDay =>
      $composableBuilder(column: $table.isAllDay, builder: (column) => column);

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CalendarEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarEventsTable,
          CalendarEventRecord,
          $$CalendarEventsTableFilterComposer,
          $$CalendarEventsTableOrderingComposer,
          $$CalendarEventsTableAnnotationComposer,
          $$CalendarEventsTableCreateCompanionBuilder,
          $$CalendarEventsTableUpdateCompanionBuilder,
          (
            CalendarEventRecord,
            BaseReferences<
              _$AppDatabase,
              $CalendarEventsTable,
              CalendarEventRecord
            >,
          ),
          CalendarEventRecord,
          PrefetchHooks Function()
        > {
  $$CalendarEventsTableTableManager(
    _$AppDatabase db,
    $CalendarEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime> endAt = const Value.absent(),
                Value<bool> isAllDay = const Value.absent(),
                Value<int?> reminderMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CalendarEventsCompanion(
                id: id,
                title: title,
                description: description,
                startAt: startAt,
                endAt: endAt,
                isAllDay: isAllDay,
                reminderMinutes: reminderMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                required DateTime startAt,
                required DateTime endAt,
                Value<bool> isAllDay = const Value.absent(),
                Value<int?> reminderMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CalendarEventsCompanion.insert(
                id: id,
                title: title,
                description: description,
                startAt: startAt,
                endAt: endAt,
                isAllDay: isAllDay,
                reminderMinutes: reminderMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarEventsTable,
      CalendarEventRecord,
      $$CalendarEventsTableFilterComposer,
      $$CalendarEventsTableOrderingComposer,
      $$CalendarEventsTableAnnotationComposer,
      $$CalendarEventsTableCreateCompanionBuilder,
      $$CalendarEventsTableUpdateCompanionBuilder,
      (
        CalendarEventRecord,
        BaseReferences<
          _$AppDatabase,
          $CalendarEventsTable,
          CalendarEventRecord
        >,
      ),
      CalendarEventRecord,
      PrefetchHooks Function()
    >;
typedef $$TodosTableCreateCompanionBuilder =
    TodosCompanion Function({
      required String id,
      required String title,
      Value<int> priority,
      Value<DateTime?> dueDate,
      Value<bool> isDone,
      Value<String> subtasksJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$TodosTableUpdateCompanionBuilder =
    TodosCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> priority,
      Value<DateTime?> dueDate,
      Value<bool> isDone,
      Value<String> subtasksJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TodosTableFilterComposer extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtasksJson => $composableBuilder(
    column: $table.subtasksJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodosTableOrderingComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtasksJson => $composableBuilder(
    column: $table.subtasksJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<String> get subtasksJson => $composableBuilder(
    column: $table.subtasksJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TodosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodosTable,
          TodoRecord,
          $$TodosTableFilterComposer,
          $$TodosTableOrderingComposer,
          $$TodosTableAnnotationComposer,
          $$TodosTableCreateCompanionBuilder,
          $$TodosTableUpdateCompanionBuilder,
          (TodoRecord, BaseReferences<_$AppDatabase, $TodosTable, TodoRecord>),
          TodoRecord,
          PrefetchHooks Function()
        > {
  $$TodosTableTableManager(_$AppDatabase db, $TodosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<String> subtasksJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodosCompanion(
                id: id,
                title: title,
                priority: priority,
                dueDate: dueDate,
                isDone: isDone,
                subtasksJson: subtasksJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<int> priority = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<String> subtasksJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodosCompanion.insert(
                id: id,
                title: title,
                priority: priority,
                dueDate: dueDate,
                isDone: isDone,
                subtasksJson: subtasksJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodosTable,
      TodoRecord,
      $$TodosTableFilterComposer,
      $$TodosTableOrderingComposer,
      $$TodosTableAnnotationComposer,
      $$TodosTableCreateCompanionBuilder,
      $$TodosTableUpdateCompanionBuilder,
      (TodoRecord, BaseReferences<_$AppDatabase, $TodosTable, TodoRecord>),
      TodoRecord,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      required String title,
      Value<int> targetPerWeek,
      Value<String> completedDaysJson,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> targetPerWeek,
      Value<String> completedDaysJson,
      Value<int> rowid,
    });

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetPerWeek => $composableBuilder(
    column: $table.targetPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedDaysJson => $composableBuilder(
    column: $table.completedDaysJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPerWeek => $composableBuilder(
    column: $table.targetPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedDaysJson => $composableBuilder(
    column: $table.completedDaysJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get targetPerWeek => $composableBuilder(
    column: $table.targetPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedDaysJson => $composableBuilder(
    column: $table.completedDaysJson,
    builder: (column) => column,
  );
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRecord,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (
            HabitRecord,
            BaseReferences<_$AppDatabase, $HabitsTable, HabitRecord>,
          ),
          HabitRecord,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> targetPerWeek = const Value.absent(),
                Value<String> completedDaysJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                title: title,
                targetPerWeek: targetPerWeek,
                completedDaysJson: completedDaysJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<int> targetPerWeek = const Value.absent(),
                Value<String> completedDaysJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                title: title,
                targetPerWeek: targetPerWeek,
                completedDaysJson: completedDaysJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRecord,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRecord, BaseReferences<_$AppDatabase, $HabitsTable, HabitRecord>),
      HabitRecord,
      PrefetchHooks Function()
    >;
typedef $$PomodoroStatsTableCreateCompanionBuilder =
    PomodoroStatsCompanion Function({
      Value<int> id,
      Value<int> completedFocusSessions,
      Value<int> totalFocusSeconds,
      Value<int> cycles,
      Value<int> focusMinutes,
    });
typedef $$PomodoroStatsTableUpdateCompanionBuilder =
    PomodoroStatsCompanion Function({
      Value<int> id,
      Value<int> completedFocusSessions,
      Value<int> totalFocusSeconds,
      Value<int> cycles,
      Value<int> focusMinutes,
    });

class $$PomodoroStatsTableFilterComposer
    extends Composer<_$AppDatabase, $PomodoroStatsTable> {
  $$PomodoroStatsTableFilterComposer({
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

  ColumnFilters<int> get completedFocusSessions => $composableBuilder(
    column: $table.completedFocusSessions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalFocusSeconds => $composableBuilder(
    column: $table.totalFocusSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycles => $composableBuilder(
    column: $table.cycles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusMinutes => $composableBuilder(
    column: $table.focusMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PomodoroStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $PomodoroStatsTable> {
  $$PomodoroStatsTableOrderingComposer({
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

  ColumnOrderings<int> get completedFocusSessions => $composableBuilder(
    column: $table.completedFocusSessions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalFocusSeconds => $composableBuilder(
    column: $table.totalFocusSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycles => $composableBuilder(
    column: $table.cycles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusMinutes => $composableBuilder(
    column: $table.focusMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PomodoroStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PomodoroStatsTable> {
  $$PomodoroStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get completedFocusSessions => $composableBuilder(
    column: $table.completedFocusSessions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalFocusSeconds => $composableBuilder(
    column: $table.totalFocusSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cycles =>
      $composableBuilder(column: $table.cycles, builder: (column) => column);

  GeneratedColumn<int> get focusMinutes => $composableBuilder(
    column: $table.focusMinutes,
    builder: (column) => column,
  );
}

class $$PomodoroStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PomodoroStatsTable,
          PomodoroStatsRecord,
          $$PomodoroStatsTableFilterComposer,
          $$PomodoroStatsTableOrderingComposer,
          $$PomodoroStatsTableAnnotationComposer,
          $$PomodoroStatsTableCreateCompanionBuilder,
          $$PomodoroStatsTableUpdateCompanionBuilder,
          (
            PomodoroStatsRecord,
            BaseReferences<
              _$AppDatabase,
              $PomodoroStatsTable,
              PomodoroStatsRecord
            >,
          ),
          PomodoroStatsRecord,
          PrefetchHooks Function()
        > {
  $$PomodoroStatsTableTableManager(_$AppDatabase db, $PomodoroStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PomodoroStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PomodoroStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PomodoroStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> completedFocusSessions = const Value.absent(),
                Value<int> totalFocusSeconds = const Value.absent(),
                Value<int> cycles = const Value.absent(),
                Value<int> focusMinutes = const Value.absent(),
              }) => PomodoroStatsCompanion(
                id: id,
                completedFocusSessions: completedFocusSessions,
                totalFocusSeconds: totalFocusSeconds,
                cycles: cycles,
                focusMinutes: focusMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> completedFocusSessions = const Value.absent(),
                Value<int> totalFocusSeconds = const Value.absent(),
                Value<int> cycles = const Value.absent(),
                Value<int> focusMinutes = const Value.absent(),
              }) => PomodoroStatsCompanion.insert(
                id: id,
                completedFocusSessions: completedFocusSessions,
                totalFocusSeconds: totalFocusSeconds,
                cycles: cycles,
                focusMinutes: focusMinutes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PomodoroStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PomodoroStatsTable,
      PomodoroStatsRecord,
      $$PomodoroStatsTableFilterComposer,
      $$PomodoroStatsTableOrderingComposer,
      $$PomodoroStatsTableAnnotationComposer,
      $$PomodoroStatsTableCreateCompanionBuilder,
      $$PomodoroStatsTableUpdateCompanionBuilder,
      (
        PomodoroStatsRecord,
        BaseReferences<_$AppDatabase, $PomodoroStatsTable, PomodoroStatsRecord>,
      ),
      PomodoroStatsRecord,
      PrefetchHooks Function()
    >;
typedef $$AlarmsTableCreateCompanionBuilder =
    AlarmsCompanion Function({
      Value<int> id,
      required int hour,
      required int minute,
      Value<String> label,
      Value<bool> enabled,
      Value<String> recurringWeekdaysJson,
      Value<int> snoozeMinutes,
      Value<bool> vibration,
      Value<bool> sound,
    });
typedef $$AlarmsTableUpdateCompanionBuilder =
    AlarmsCompanion Function({
      Value<int> id,
      Value<int> hour,
      Value<int> minute,
      Value<String> label,
      Value<bool> enabled,
      Value<String> recurringWeekdaysJson,
      Value<int> snoozeMinutes,
      Value<bool> vibration,
      Value<bool> sound,
    });

class $$AlarmsTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer({
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

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurringWeekdaysJson => $composableBuilder(
    column: $table.recurringWeekdaysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get vibration => $composableBuilder(
    column: $table.vibration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sound => $composableBuilder(
    column: $table.sound,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AlarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer({
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

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurringWeekdaysJson => $composableBuilder(
    column: $table.recurringWeekdaysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get vibration => $composableBuilder(
    column: $table.vibration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sound => $composableBuilder(
    column: $table.sound,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AlarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get recurringWeekdaysJson => $composableBuilder(
    column: $table.recurringWeekdaysJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get vibration =>
      $composableBuilder(column: $table.vibration, builder: (column) => column);

  GeneratedColumn<bool> get sound =>
      $composableBuilder(column: $table.sound, builder: (column) => column);
}

class $$AlarmsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlarmsTable,
          AlarmRecord,
          $$AlarmsTableFilterComposer,
          $$AlarmsTableOrderingComposer,
          $$AlarmsTableAnnotationComposer,
          $$AlarmsTableCreateCompanionBuilder,
          $$AlarmsTableUpdateCompanionBuilder,
          (
            AlarmRecord,
            BaseReferences<_$AppDatabase, $AlarmsTable, AlarmRecord>,
          ),
          AlarmRecord,
          PrefetchHooks Function()
        > {
  $$AlarmsTableTableManager(_$AppDatabase db, $AlarmsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> recurringWeekdaysJson = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
                Value<bool> vibration = const Value.absent(),
                Value<bool> sound = const Value.absent(),
              }) => AlarmsCompanion(
                id: id,
                hour: hour,
                minute: minute,
                label: label,
                enabled: enabled,
                recurringWeekdaysJson: recurringWeekdaysJson,
                snoozeMinutes: snoozeMinutes,
                vibration: vibration,
                sound: sound,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int hour,
                required int minute,
                Value<String> label = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> recurringWeekdaysJson = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
                Value<bool> vibration = const Value.absent(),
                Value<bool> sound = const Value.absent(),
              }) => AlarmsCompanion.insert(
                id: id,
                hour: hour,
                minute: minute,
                label: label,
                enabled: enabled,
                recurringWeekdaysJson: recurringWeekdaysJson,
                snoozeMinutes: snoozeMinutes,
                vibration: vibration,
                sound: sound,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AlarmsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlarmsTable,
      AlarmRecord,
      $$AlarmsTableFilterComposer,
      $$AlarmsTableOrderingComposer,
      $$AlarmsTableAnnotationComposer,
      $$AlarmsTableCreateCompanionBuilder,
      $$AlarmsTableUpdateCompanionBuilder,
      (AlarmRecord, BaseReferences<_$AppDatabase, $AlarmsTable, AlarmRecord>),
      AlarmRecord,
      PrefetchHooks Function()
    >;
typedef $$VoiceMemosTableCreateCompanionBuilder =
    VoiceMemosCompanion Function({
      required String id,
      required String transcript,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$VoiceMemosTableUpdateCompanionBuilder =
    VoiceMemosCompanion Function({
      Value<String> id,
      Value<String> transcript,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$VoiceMemosTableFilterComposer
    extends Composer<_$AppDatabase, $VoiceMemosTable> {
  $$VoiceMemosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VoiceMemosTableOrderingComposer
    extends Composer<_$AppDatabase, $VoiceMemosTable> {
  $$VoiceMemosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VoiceMemosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VoiceMemosTable> {
  $$VoiceMemosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transcript => $composableBuilder(
    column: $table.transcript,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$VoiceMemosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VoiceMemosTable,
          VoiceMemoRecord,
          $$VoiceMemosTableFilterComposer,
          $$VoiceMemosTableOrderingComposer,
          $$VoiceMemosTableAnnotationComposer,
          $$VoiceMemosTableCreateCompanionBuilder,
          $$VoiceMemosTableUpdateCompanionBuilder,
          (
            VoiceMemoRecord,
            BaseReferences<_$AppDatabase, $VoiceMemosTable, VoiceMemoRecord>,
          ),
          VoiceMemoRecord,
          PrefetchHooks Function()
        > {
  $$VoiceMemosTableTableManager(_$AppDatabase db, $VoiceMemosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VoiceMemosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VoiceMemosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VoiceMemosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> transcript = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VoiceMemosCompanion(
                id: id,
                transcript: transcript,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String transcript,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VoiceMemosCompanion.insert(
                id: id,
                transcript: transcript,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VoiceMemosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VoiceMemosTable,
      VoiceMemoRecord,
      $$VoiceMemosTableFilterComposer,
      $$VoiceMemosTableOrderingComposer,
      $$VoiceMemosTableAnnotationComposer,
      $$VoiceMemosTableCreateCompanionBuilder,
      $$VoiceMemosTableUpdateCompanionBuilder,
      (
        VoiceMemoRecord,
        BaseReferences<_$AppDatabase, $VoiceMemosTable, VoiceMemoRecord>,
      ),
      VoiceMemoRecord,
      PrefetchHooks Function()
    >;
typedef $$CalculatorPrefsTableCreateCompanionBuilder =
    CalculatorPrefsCompanion Function({
      Value<int> id,
      Value<String> input,
      Value<String> output,
      Value<double> memory,
    });
typedef $$CalculatorPrefsTableUpdateCompanionBuilder =
    CalculatorPrefsCompanion Function({
      Value<int> id,
      Value<String> input,
      Value<String> output,
      Value<double> memory,
    });

class $$CalculatorPrefsTableFilterComposer
    extends Composer<_$AppDatabase, $CalculatorPrefsTable> {
  $$CalculatorPrefsTableFilterComposer({
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

  ColumnFilters<String> get input => $composableBuilder(
    column: $table.input,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get output => $composableBuilder(
    column: $table.output,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get memory => $composableBuilder(
    column: $table.memory,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalculatorPrefsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalculatorPrefsTable> {
  $$CalculatorPrefsTableOrderingComposer({
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

  ColumnOrderings<String> get input => $composableBuilder(
    column: $table.input,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get output => $composableBuilder(
    column: $table.output,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get memory => $composableBuilder(
    column: $table.memory,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalculatorPrefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalculatorPrefsTable> {
  $$CalculatorPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get input =>
      $composableBuilder(column: $table.input, builder: (column) => column);

  GeneratedColumn<String> get output =>
      $composableBuilder(column: $table.output, builder: (column) => column);

  GeneratedColumn<double> get memory =>
      $composableBuilder(column: $table.memory, builder: (column) => column);
}

class $$CalculatorPrefsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalculatorPrefsTable,
          CalculatorPrefRecord,
          $$CalculatorPrefsTableFilterComposer,
          $$CalculatorPrefsTableOrderingComposer,
          $$CalculatorPrefsTableAnnotationComposer,
          $$CalculatorPrefsTableCreateCompanionBuilder,
          $$CalculatorPrefsTableUpdateCompanionBuilder,
          (
            CalculatorPrefRecord,
            BaseReferences<
              _$AppDatabase,
              $CalculatorPrefsTable,
              CalculatorPrefRecord
            >,
          ),
          CalculatorPrefRecord,
          PrefetchHooks Function()
        > {
  $$CalculatorPrefsTableTableManager(
    _$AppDatabase db,
    $CalculatorPrefsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalculatorPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalculatorPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalculatorPrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> input = const Value.absent(),
                Value<String> output = const Value.absent(),
                Value<double> memory = const Value.absent(),
              }) => CalculatorPrefsCompanion(
                id: id,
                input: input,
                output: output,
                memory: memory,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> input = const Value.absent(),
                Value<String> output = const Value.absent(),
                Value<double> memory = const Value.absent(),
              }) => CalculatorPrefsCompanion.insert(
                id: id,
                input: input,
                output: output,
                memory: memory,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalculatorPrefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalculatorPrefsTable,
      CalculatorPrefRecord,
      $$CalculatorPrefsTableFilterComposer,
      $$CalculatorPrefsTableOrderingComposer,
      $$CalculatorPrefsTableAnnotationComposer,
      $$CalculatorPrefsTableCreateCompanionBuilder,
      $$CalculatorPrefsTableUpdateCompanionBuilder,
      (
        CalculatorPrefRecord,
        BaseReferences<
          _$AppDatabase,
          $CalculatorPrefsTable,
          CalculatorPrefRecord
        >,
      ),
      CalculatorPrefRecord,
      PrefetchHooks Function()
    >;
typedef $$CalculatorHistoryTableCreateCompanionBuilder =
    CalculatorHistoryCompanion Function({
      Value<int> id,
      required String item,
      Value<DateTime> createdAt,
    });
typedef $$CalculatorHistoryTableUpdateCompanionBuilder =
    CalculatorHistoryCompanion Function({
      Value<int> id,
      Value<String> item,
      Value<DateTime> createdAt,
    });

class $$CalculatorHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $CalculatorHistoryTable> {
  $$CalculatorHistoryTableFilterComposer({
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

  ColumnFilters<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalculatorHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $CalculatorHistoryTable> {
  $$CalculatorHistoryTableOrderingComposer({
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

  ColumnOrderings<String> get item => $composableBuilder(
    column: $table.item,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalculatorHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalculatorHistoryTable> {
  $$CalculatorHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get item =>
      $composableBuilder(column: $table.item, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CalculatorHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalculatorHistoryTable,
          CalculatorHistoryRecord,
          $$CalculatorHistoryTableFilterComposer,
          $$CalculatorHistoryTableOrderingComposer,
          $$CalculatorHistoryTableAnnotationComposer,
          $$CalculatorHistoryTableCreateCompanionBuilder,
          $$CalculatorHistoryTableUpdateCompanionBuilder,
          (
            CalculatorHistoryRecord,
            BaseReferences<
              _$AppDatabase,
              $CalculatorHistoryTable,
              CalculatorHistoryRecord
            >,
          ),
          CalculatorHistoryRecord,
          PrefetchHooks Function()
        > {
  $$CalculatorHistoryTableTableManager(
    _$AppDatabase db,
    $CalculatorHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalculatorHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalculatorHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalculatorHistoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> item = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CalculatorHistoryCompanion(
                id: id,
                item: item,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String item,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CalculatorHistoryCompanion.insert(
                id: id,
                item: item,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalculatorHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalculatorHistoryTable,
      CalculatorHistoryRecord,
      $$CalculatorHistoryTableFilterComposer,
      $$CalculatorHistoryTableOrderingComposer,
      $$CalculatorHistoryTableAnnotationComposer,
      $$CalculatorHistoryTableCreateCompanionBuilder,
      $$CalculatorHistoryTableUpdateCompanionBuilder,
      (
        CalculatorHistoryRecord,
        BaseReferences<
          _$AppDatabase,
          $CalculatorHistoryTable,
          CalculatorHistoryRecord
        >,
      ),
      CalculatorHistoryRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$CalendarEventsTableTableManager get calendarEvents =>
      $$CalendarEventsTableTableManager(_db, _db.calendarEvents);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db, _db.todos);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$PomodoroStatsTableTableManager get pomodoroStats =>
      $$PomodoroStatsTableTableManager(_db, _db.pomodoroStats);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
  $$VoiceMemosTableTableManager get voiceMemos =>
      $$VoiceMemosTableTableManager(_db, _db.voiceMemos);
  $$CalculatorPrefsTableTableManager get calculatorPrefs =>
      $$CalculatorPrefsTableTableManager(_db, _db.calculatorPrefs);
  $$CalculatorHistoryTableTableManager get calculatorHistory =>
      $$CalculatorHistoryTableTableManager(_db, _db.calculatorHistory);
}
