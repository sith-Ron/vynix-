import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:vynix/features/pomodoro/presentation/providers/pomodoro_provider.dart';
import 'package:vynix/features/todos/presentation/providers/todos_provider.dart';
import 'package:vynix/shared/services/home_widget/home_widget_service.dart';

part 'home_widget_provider.g.dart';

@riverpod
HomeWidgetService homeWidgetService(Ref ref) {
  return HomeWidgetService.instance;
}

/// Watches todos, today's calendar events, and pomodoro state, then pushes
/// the latest stats to the native home-screen / lock-screen widget.
@riverpod
void homeWidgetSync(Ref ref) {
  final todos = ref.watch(todosControllerProvider);
  final pomodoro = ref.watch(pomodoroControllerProvider);

  // Today's calendar events from the repository stream.
  final today = DateTime.now();
  final repo = ref.watch(calendarRepositoryProvider);
  final eventsSub = repo.watchDay(today).listen((events) {
    _pushUpdate(
      todos: todos,
      todayEventCount: events.length,
      pomodoro: pomodoro,
    );
  });
  ref.onDispose(eventsSub.cancel);

  // Also push immediately with event count 0 (will be corrected by stream).
  _pushUpdate(todos: todos, todayEventCount: 0, pomodoro: pomodoro);
}

void _pushUpdate({
  required List<TodoItem> todos,
  required int todayEventCount,
  required PomodoroState pomodoro,
}) {
  final pending = todos.where((t) => !t.isDone).toList();
  final nextTask = pending.isNotEmpty ? pending.first.title : null;

  unawaited(
    HomeWidgetService.instance.updateDashboard(
      pendingTasks: pending.length,
      todayEvents: todayEventCount,
      focusMinutes: pomodoro.totalFocusSeconds ~/ 60,
      nextTaskTitle: nextTask,
    ),
  );
}
