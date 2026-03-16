import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vynix/features/todos/presentation/providers/todos_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(sortedTodosProvider);

    return AdaptiveSectionScaffold(
      title: 'Tasks',
      floatingActionButton: FloatingActionButton(
        heroTag: 'todos_fab',
        tooltip: 'Add task',
        onPressed: () => _showAddTodoDialog(context, ref),
        child: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          if (todos.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No tasks yet. Tap + to add one.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverList.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: VynixGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox.adaptive(
                                value: todo.isDone,
                                onChanged: (_) => ref
                                    .read(todosControllerProvider.notifier)
                                    .toggleDone(todo.id),
                              ),
                              Expanded(
                                child: Text(
                                  todo.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        decoration: todo.isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => ref
                                    .read(todosControllerProvider.notifier)
                                    .removeTodo(todo.id),
                                icon: const Icon(CupertinoIcons.delete),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Chip(label: Text(_priorityLabel(todo.priority))),
                              if (todo.dueDate != null)
                                Chip(
                                  label: Text(
                                    'Due ${DateFormat.yMMMd().format(todo.dueDate!)}',
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          for (final subtask in todo.subtasks)
                            CheckboxListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(subtask.title),
                              value: subtask.isDone,
                              onChanged: (_) => ref
                                  .read(todosControllerProvider.notifier)
                                  .toggleSubtask(
                                    todoId: todo.id,
                                    subtaskId: subtask.id,
                                  ),
                            ),
                          TextButton.icon(
                            onPressed: () =>
                                _showAddSubtaskDialog(context, ref, todo.id),
                            icon: const Icon(CupertinoIcons.add_circled),
                            label: const Text('Add subtask'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  String _priorityLabel(TodoPriority priority) {
    return switch (priority) {
      TodoPriority.low => 'Low',
      TodoPriority.medium => 'Medium',
      TodoPriority.high => 'High',
    };
  }

  Future<void> _showAddTodoDialog(BuildContext context, WidgetRef ref) async {
    final titleController = TextEditingController();
    TodoPriority selectedPriority = TodoPriority.medium;
    DateTime? selectedDate;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('New task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Task title'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<TodoPriority>(
                    initialValue: selectedPriority,
                    items: TodoPriority.values
                        .map(
                          (priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(_priorityLabel(priority)),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => selectedPriority = value);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedDate == null
                              ? 'No due date'
                              : DateFormat.yMMMd().format(selectedDate!),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setDialogState(() => selectedDate = picked);
                          }
                        },
                        child: const Text('Pick date'),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    ref
                        .read(todosControllerProvider.notifier)
                        .addTodo(
                          title: titleController.text,
                          priority: selectedPriority,
                          dueDate: selectedDate,
                        );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showAddSubtaskDialog(
    BuildContext context,
    WidgetRef ref,
    String todoId,
  ) async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New subtask'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Subtask title'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                ref
                    .read(todosControllerProvider.notifier)
                    .addSubtask(todoId: todoId, title: controller.text);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
