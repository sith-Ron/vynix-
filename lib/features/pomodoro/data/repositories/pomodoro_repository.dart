import 'package:vynix/shared/services/database/app_database.dart';

class PomodoroRepository {
  const PomodoroRepository(this._db);

  final AppDatabase _db;

  Stream<PomodoroStatsRecord> watchStats() => _db.watchPomodoroStats();

  Future<void> saveStats({
    required int completedFocusSessions,
    required int totalFocusSeconds,
    required int cycles,
  }) {
    return _db.savePomodoroStats(
      completedFocusSessions: completedFocusSessions,
      totalFocusSeconds: totalFocusSeconds,
      cycles: cycles,
    );
  }
}
