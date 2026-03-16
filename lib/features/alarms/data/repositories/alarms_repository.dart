import 'package:vynix/shared/services/database/app_database.dart';

class AlarmsRepository {
  const AlarmsRepository(this._db);

  final AppDatabase _db;

  Stream<List<AlarmRecord>> watchAlarms() => _db.watchAlarms();

  Future<void> upsert(AlarmsCompanion companion) => _db.upsertAlarm(companion);

  Future<void> delete(int id) => _db.deleteAlarm(id);
}
