import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/shared/services/database/app_database.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}
