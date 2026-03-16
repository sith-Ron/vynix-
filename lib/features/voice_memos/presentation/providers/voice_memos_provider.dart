import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/features/voice_memos/data/repositories/voice_memos_repository.dart';
import 'package:vynix/shared/services/database/app_database.dart';

part 'voice_memos_provider.g.dart';

@immutable
class VoiceMemoItem {
  const VoiceMemoItem({
    required this.id,
    required this.transcript,
    required this.createdAt,
  });

  final String id;
  final String transcript;
  final DateTime createdAt;
}

@riverpod
class VoiceMemosController extends _$VoiceMemosController {
  StreamSubscription<List<VoiceMemoRecord>>? _sub;

  @override
  List<VoiceMemoItem> build() {
    if (_sub == null) {
      final repo = ref.read(voiceMemosRepositoryProvider);
      _sub = repo.watchMemos().listen((rows) {
        state = rows
            .map(
              (row) => VoiceMemoItem(
                id: row.id,
                transcript: row.transcript,
                createdAt: row.createdAt,
              ),
            )
            .toList(growable: false);
      });
      ref.onDispose(() => _sub?.cancel());
    }
    return const [];
  }

  void addMemo(String transcript) {
    final cleaned = transcript.trim();
    if (cleaned.isEmpty) {
      return;
    }
    final now = DateTime.now();
    unawaited(
      ref
          .read(voiceMemosRepositoryProvider)
          .upsert(
            VoiceMemosCompanion(
              id: Value(now.microsecondsSinceEpoch.toString()),
              transcript: Value(cleaned),
              createdAt: Value(now),
            ),
          ),
    );
  }

  void remove(String id) {
    unawaited(ref.read(voiceMemosRepositoryProvider).delete(id));
  }
}

@riverpod
VoiceMemosRepository voiceMemosRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return VoiceMemosRepository(db);
}
