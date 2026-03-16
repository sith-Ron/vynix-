import 'dart:io';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbFile = File(path.join(documentsDirectory.path, 'vynix.sqlite'));
    return NativeDatabase.createInBackground(dbFile);
  });
}

@DataClassName('NoteRecord')
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withDefault(const Constant('Untitled'))();

  // Serialized Delta JSON from flutter_quill document.
  TextColumn get contentDeltaJson => text().withDefault(const Constant('[]'))();

  // Tags are stored as a JSON array string, e.g. ["work", "idea"].
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();

  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('CalendarEventRecord')
class CalendarEvents extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withDefault(const Constant('New Event'))();

  TextColumn get description => text().withDefault(const Constant(''))();

  DateTimeColumn get startAt => dateTime()();

  DateTimeColumn get endAt => dateTime()();

  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();

  IntColumn get reminderMinutes => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('TodoRecord')
class Todos extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get priority => integer().withDefault(const Constant(1))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  TextColumn get subtasksJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('HabitRecord')
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get targetPerWeek => integer().withDefault(const Constant(4))();
  TextColumn get completedDaysJson =>
      text().withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('PomodoroStatsRecord')
class PomodoroStats extends Table {
  IntColumn get id => integer()();
  IntColumn get completedFocusSessions =>
      integer().withDefault(const Constant(0))();
  IntColumn get totalFocusSeconds => integer().withDefault(const Constant(0))();
  IntColumn get cycles => integer().withDefault(const Constant(0))();
  IntColumn get focusMinutes => integer().withDefault(const Constant(25))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('AlarmRecord')
class Alarms extends Table {
  IntColumn get id => integer()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  TextColumn get label => text().withDefault(const Constant('Alarm'))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  TextColumn get recurringWeekdaysJson =>
      text().withDefault(const Constant('[]'))();
  IntColumn get snoozeMinutes => integer().withDefault(const Constant(10))();
  BoolColumn get vibration => boolean().withDefault(const Constant(true))();
  BoolColumn get sound => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('VoiceMemoRecord')
class VoiceMemos extends Table {
  TextColumn get id => text()();
  TextColumn get transcript => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('CalculatorPrefRecord')
class CalculatorPrefs extends Table {
  IntColumn get id => integer()();
  TextColumn get input => text().withDefault(const Constant(''))();
  TextColumn get output => text().withDefault(const Constant('0'))();
  RealColumn get memory => real().withDefault(const Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('CalculatorHistoryRecord')
class CalculatorHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get item => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Notes,
    CalendarEvents,
    Todos,
    Habits,
    PomodoroStats,
    Alarms,
    VoiceMemos,
    CalculatorPrefs,
    CalculatorHistory,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(calendarEvents);
      }
      if (from < 3) {
        await migrator.createTable(todos);
        await migrator.createTable(habits);
        await migrator.createTable(pomodoroStats);
        await migrator.createTable(alarms);
        await migrator.createTable(voiceMemos);
        await migrator.createTable(calculatorPrefs);
        await migrator.createTable(calculatorHistory);
      }
      if (from < 4) {
        final hasFocusMinutes = await _columnExists(
          tableName: 'pomodoro_stats',
          columnName: 'focus_minutes',
        );
        if (!hasFocusMinutes) {
          await migrator.addColumn(pomodoroStats, pomodoroStats.focusMinutes);
        }
      }
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        await into(pomodoroStats).insert(
          const PomodoroStatsCompanion(
            id: Value(1),
            completedFocusSessions: Value(0),
            totalFocusSeconds: Value(0),
            cycles: Value(0),
            focusMinutes: Value(25),
          ),
        );
        await into(calculatorPrefs).insert(
          const CalculatorPrefsCompanion(
            id: Value(1),
            input: Value(''),
            output: Value('0'),
            memory: Value(0),
          ),
        );
      }
    },
  );

  Future<bool> _columnExists({
    required String tableName,
    required String columnName,
  }) async {
    final rows = await customSelect('PRAGMA table_info("$tableName")').get();
    for (final row in rows) {
      final name = row.data['name']?.toString();
      if (name == null) {
        continue;
      }
      if (name.toLowerCase() == columnName.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  Stream<List<NoteRecord>> watchNotes({
    required String searchQuery,
    String? selectedTag,
  }) {
    final q = select(notes)
      ..orderBy([
        (t) => OrderingTerm.desc(t.isPinned),
        (t) => OrderingTerm.desc(t.updatedAt),
      ]);

    if (searchQuery.trim().isNotEmpty) {
      final term = '%${searchQuery.trim().toLowerCase()}%';
      q.where(
        (tbl) =>
            tbl.title.lower().like(term) |
            tbl.contentDeltaJson.lower().like(term) |
            tbl.tagsJson.lower().like(term),
      );
    }

    if (selectedTag != null && selectedTag.trim().isNotEmpty) {
      final escapedTag = jsonEncode(selectedTag.trim());
      q.where((tbl) => tbl.tagsJson.like('%$escapedTag%'));
    }

    return q.watch();
  }

  Stream<List<String>> watchAllTags() {
    return select(notes).watch().map((rows) {
      final tags = <String>{};
      for (final row in rows) {
        try {
          final decoded = jsonDecode(row.tagsJson);
          if (decoded is List) {
            for (final value in decoded) {
              final tag = value.toString().trim();
              if (tag.isNotEmpty) {
                tags.add(tag);
              }
            }
          }
        } catch (_) {
          // Keep stream resilient if older/corrupted payload exists.
        }
      }
      final ordered = tags.toList()..sort();
      return ordered;
    });
  }

  Future<NoteRecord> insertNote({
    required String title,
    required String contentDeltaJson,
    required String tagsJson,
  }) async {
    final now = DateTime.now();
    final id = await into(notes).insert(
      NotesCompanion(
        title: Value(title),
        contentDeltaJson: Value(contentDeltaJson),
        tagsJson: Value(tagsJson),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    return (select(notes)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<NoteRecord> updateNote(NoteRecord note) async {
    final updated = note.copyWith(updatedAt: DateTime.now());
    await update(notes).replace(updated);
    return updated;
  }

  Future<void> deleteNote(int id) {
    return (delete(notes)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<CalendarEventRecord>> watchEventsInRange({
    required DateTime startInclusive,
    required DateTime endExclusive,
  }) {
    final q = select(calendarEvents)
      ..where(
        (tbl) =>
            tbl.startAt.isSmallerThanValue(endExclusive) &
            tbl.endAt.isBiggerOrEqualValue(startInclusive),
      )
      ..orderBy([
        (tbl) => OrderingTerm.asc(tbl.startAt),
        (tbl) => OrderingTerm.asc(tbl.endAt),
      ]);
    return q.watch();
  }

  Future<CalendarEventRecord> insertCalendarEvent({
    required String title,
    required String description,
    required DateTime startAt,
    required DateTime endAt,
    required bool isAllDay,
    required int? reminderMinutes,
  }) async {
    final now = DateTime.now();
    final id = await into(calendarEvents).insert(
      CalendarEventsCompanion(
        title: Value(title),
        description: Value(description),
        startAt: Value(startAt),
        endAt: Value(endAt),
        isAllDay: Value(isAllDay),
        reminderMinutes: Value(reminderMinutes),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    return (select(
      calendarEvents,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<CalendarEventRecord> updateCalendarEvent(
    CalendarEventRecord event,
  ) async {
    final updated = event.copyWith(updatedAt: DateTime.now());
    await update(calendarEvents).replace(updated);
    return updated;
  }

  Future<void> deleteCalendarEvent(int id) {
    return (delete(calendarEvents)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<TodoRecord>> watchTodos() {
    return (select(todos)..orderBy([
          (t) => OrderingTerm.asc(t.isDone),
          (t) => OrderingTerm.asc(t.dueDate),
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
        .watch();
  }

  Future<void> upsertTodo(TodosCompanion companion) {
    return into(todos).insertOnConflictUpdate(companion);
  }

  Future<void> deleteTodo(String id) {
    return (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<HabitRecord>> watchHabits() {
    return (select(
      habits,
    )..orderBy([(h) => OrderingTerm.asc(h.title)])).watch();
  }

  Future<void> upsertHabit(HabitsCompanion companion) {
    return into(habits).insertOnConflictUpdate(companion);
  }

  Future<void> deleteHabit(String id) {
    return (delete(habits)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<PomodoroStatsRecord> watchPomodoroStats() {
    final q = select(pomodoroStats)..where((tbl) => tbl.id.equals(1));
    return q.watchSingleOrNull().map((row) {
      return row ??
          const PomodoroStatsRecord(
            id: 1,
            completedFocusSessions: 0,
            totalFocusSeconds: 0,
            cycles: 0,
            focusMinutes: 25,
          );
    });
  }

  Future<void> savePomodoroStats({
    required int completedFocusSessions,
    required int totalFocusSeconds,
    required int cycles,
    required int focusMinutes,
  }) {
    return into(pomodoroStats).insertOnConflictUpdate(
      PomodoroStatsCompanion(
        id: const Value(1),
        completedFocusSessions: Value(completedFocusSessions),
        totalFocusSeconds: Value(totalFocusSeconds),
        cycles: Value(cycles),
        focusMinutes: Value(focusMinutes),
      ),
    );
  }

  Stream<List<AlarmRecord>> watchAlarms() {
    return (select(alarms)..orderBy([
          (a) => OrderingTerm.asc(a.hour),
          (a) => OrderingTerm.asc(a.minute),
        ]))
        .watch();
  }

  Future<void> upsertAlarm(AlarmsCompanion companion) {
    return into(alarms).insertOnConflictUpdate(companion);
  }

  Future<void> deleteAlarm(int id) {
    return (delete(alarms)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<VoiceMemoRecord>> watchVoiceMemos() {
    return (select(
      voiceMemos,
    )..orderBy([(m) => OrderingTerm.desc(m.createdAt)])).watch();
  }

  Future<void> upsertVoiceMemo(VoiceMemosCompanion companion) {
    return into(voiceMemos).insertOnConflictUpdate(companion);
  }

  Future<void> deleteVoiceMemo(String id) {
    return (delete(voiceMemos)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<CalculatorPrefRecord> watchCalculatorPrefs() {
    final q = select(calculatorPrefs)..where((tbl) => tbl.id.equals(1));
    return q.watchSingleOrNull().map((row) {
      return row ??
          const CalculatorPrefRecord(id: 1, input: '', output: '0', memory: 0);
    });
  }

  Future<void> saveCalculatorPrefs({
    required String input,
    required String output,
    required double memory,
  }) {
    return into(calculatorPrefs).insertOnConflictUpdate(
      CalculatorPrefsCompanion(
        id: const Value(1),
        input: Value(input),
        output: Value(output),
        memory: Value(memory),
      ),
    );
  }

  Stream<List<CalculatorHistoryRecord>> watchCalculatorHistory() {
    return (select(calculatorHistory)
          ..orderBy([(h) => OrderingTerm.desc(h.createdAt)])
          ..limit(20))
        .watch();
  }

  Future<void> addCalculatorHistory(String item) {
    return into(
      calculatorHistory,
    ).insert(CalculatorHistoryCompanion(item: Value(item)));
  }
}
