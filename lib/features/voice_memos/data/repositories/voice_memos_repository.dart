import 'package:vynix/shared/services/database/app_database.dart';

class VoiceMemosRepository {
  const VoiceMemosRepository(this._db);

  final AppDatabase _db;

  Stream<List<VoiceMemoRecord>> watchMemos() => _db.watchVoiceMemos();

  Future<void> upsert(VoiceMemosCompanion companion) =>
      _db.upsertVoiceMemo(companion);

  Future<void> delete(String id) => _db.deleteVoiceMemo(id);
}
