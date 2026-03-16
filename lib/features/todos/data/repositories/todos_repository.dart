import 'package:vynix/shared/services/database/app_database.dart';

class TodosRepository {
  const TodosRepository(this._db);

  final AppDatabase _db;

  Stream<List<TodoRecord>> watchTodos() => _db.watchTodos();

  Future<void> upsert(TodosCompanion companion) => _db.upsertTodo(companion);

  Future<void> delete(String id) => _db.deleteTodo(id);
}
