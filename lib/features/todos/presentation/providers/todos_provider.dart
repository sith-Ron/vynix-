import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/features/todos/data/repositories/todos_repository.dart';
import 'package:vynix/shared/services/database/app_database.dart';

part 'todos_provider.g.dart';

enum TodoPriority { low, medium, high }

@immutable
class TodoSubtask {
  const TodoSubtask({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  final String id;
  final String title;
  final bool isDone;

  TodoSubtask copyWith({String? id, String? title, bool? isDone}) {
    return TodoSubtask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}

@immutable
class TodoItem {
  const TodoItem({
    required this.id,
    required this.title,
    required this.priority,
    required this.createdAt,
    this.dueDate,
    this.isDone = false,
    this.subtasks = const <TodoSubtask>[],
  });

  final String id;
  final String title;
  final TodoPriority priority;
  final DateTime createdAt;
  final DateTime? dueDate;
  final bool isDone;
  final List<TodoSubtask> subtasks;

  TodoItem copyWith({
    String? id,
    String? title,
    TodoPriority? priority,
    DateTime? createdAt,
    DateTime? dueDate,
    bool clearDueDate = false,
    bool? isDone,
    List<TodoSubtask>? subtasks,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      dueDate: clearDueDate ? null : (dueDate ?? this.dueDate),
      isDone: isDone ?? this.isDone,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}

@riverpod
class TodosController extends _$TodosController {
  StreamSubscription<List<TodoRecord>>? _sub;

  @override
  List<TodoItem> build() {
    if (_sub == null) {
      final repo = ref.read(todosRepositoryProvider);
      _sub = repo.watchTodos().listen((rows) {
        state = rows.map(_fromRecord).toList(growable: false);
      });
      ref.onDispose(() => _sub?.cancel());
    }
    return const [];
  }

  void addTodo({
    required String title,
    required TodoPriority priority,
    DateTime? dueDate,
  }) {
    final cleaned = title.trim();
    if (cleaned.isEmpty) {
      return;
    }

    final item = TodoItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: cleaned,
      priority: priority,
      dueDate: dueDate,
      createdAt: DateTime.now(),
    );
    unawaited(_persist(item));
  }

  void toggleDone(String id) {
    for (final item in state) {
      if (item.id == id) {
        unawaited(_persist(item.copyWith(isDone: !item.isDone)));
        break;
      }
    }
  }

  void removeTodo(String id) {
    unawaited(ref.read(todosRepositoryProvider).delete(id));
  }

  void addSubtask({required String todoId, required String title}) {
    final cleaned = title.trim();
    if (cleaned.isEmpty) {
      return;
    }

    for (final item in state) {
      if (item.id == todoId) {
        unawaited(
          _persist(
            item.copyWith(
              subtasks: [
                ...item.subtasks,
                TodoSubtask(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  title: cleaned,
                ),
              ],
            ),
          ),
        );
        break;
      }
    }
  }

  void toggleSubtask({required String todoId, required String subtaskId}) {
    for (final item in state) {
      if (item.id == todoId) {
        unawaited(
          _persist(
            item.copyWith(
              subtasks: [
                for (final sub in item.subtasks)
                  if (sub.id == subtaskId)
                    sub.copyWith(isDone: !sub.isDone)
                  else
                    sub,
              ],
            ),
          ),
        );
        break;
      }
    }
  }

  Future<void> _persist(TodoItem item) {
    return ref
        .read(todosRepositoryProvider)
        .upsert(
          TodosCompanion(
            id: Value(item.id),
            title: Value(item.title),
            priority: Value(item.priority.index),
            dueDate: Value(item.dueDate),
            isDone: Value(item.isDone),
            subtasksJson: Value(
              jsonEncode(
                item.subtasks
                    .map(
                      (sub) => {
                        'id': sub.id,
                        'title': sub.title,
                        'isDone': sub.isDone,
                      },
                    )
                    .toList(growable: false),
              ),
            ),
            createdAt: Value(item.createdAt),
          ),
        );
  }

  TodoItem _fromRecord(TodoRecord row) {
    final subtasks = <TodoSubtask>[];
    try {
      final decoded = jsonDecode(row.subtasksJson);
      if (decoded is List) {
        for (final raw in decoded) {
          if (raw is Map) {
            subtasks.add(
              TodoSubtask(
                id: (raw['id'] ?? '').toString(),
                title: (raw['title'] ?? '').toString(),
                isDone: raw['isDone'] == true,
              ),
            );
          }
        }
      }
    } catch (_) {
      // Keep resilient on malformed payloads.
    }

    return TodoItem(
      id: row.id,
      title: row.title,
      priority: TodoPriority.values[row.priority.clamp(0, 2)],
      createdAt: row.createdAt,
      dueDate: row.dueDate,
      isDone: row.isDone,
      subtasks: subtasks,
    );
  }
}

@riverpod
TodosRepository todosRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return TodosRepository(db);
}

@riverpod
List<TodoItem> sortedTodos(Ref ref) {
  final items = [...ref.watch(todosControllerProvider)];
  items.sort((a, b) {
    if (a.isDone != b.isDone) {
      return a.isDone ? 1 : -1;
    }

    final dueA = a.dueDate;
    final dueB = b.dueDate;
    if (dueA != null && dueB != null) {
      return dueA.compareTo(dueB);
    }
    if (dueA != null) {
      return -1;
    }
    if (dueB != null) {
      return 1;
    }
    return b.createdAt.compareTo(a.createdAt);
  });
  return items;
}
