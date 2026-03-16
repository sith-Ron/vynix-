import 'package:vynix/shared/services/database/app_database.dart';

class CalculatorRepository {
  const CalculatorRepository(this._db);

  final AppDatabase _db;

  Stream<CalculatorPrefRecord> watchPrefs() => _db.watchCalculatorPrefs();

  Future<void> savePrefs({
    required String input,
    required String output,
    required double memory,
  }) {
    return _db.saveCalculatorPrefs(
      input: input,
      output: output,
      memory: memory,
    );
  }

  Stream<List<CalculatorHistoryRecord>> watchHistory() =>
      _db.watchCalculatorHistory();

  Future<void> addHistory(String item) => _db.addCalculatorHistory(item);
}
