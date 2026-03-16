import 'package:vynix/shared/services/database/app_database.dart';

class HabitsRepository {
  const HabitsRepository(this._db);

  final AppDatabase _db;

  Stream<List<HabitRecord>> watchHabits() => _db.watchHabits();

  Future<void> upsert(HabitsCompanion companion) => _db.upsertHabit(companion);

  Future<void> delete(String id) => _db.deleteHabit(id);
}
