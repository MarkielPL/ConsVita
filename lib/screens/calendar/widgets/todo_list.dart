import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/todo_provider.dart';
import '../../../models/todo_model.dart';

/// Widżet wyświetlający listę zadań do wykonania na wybrany dzień
class TodoList extends ConsumerWidget {
  final DateTime selectedDate;
  /// Konstruktor przyjmujący datę, dla której mają być wyświetlane zadania
  const TodoList({super.key, required this.selectedDate});
  /// Buduje widżet listy zadań
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final notifier = ref.read(todoProvider.notifier);

    final todosForDay = todos.where((todo) =>
      todo.date.year == selectedDate.year &&
      todo.date.month == selectedDate.month &&
      todo.date.day == selectedDate.day,
    ).toList()
      ..sort((a, b) => a.isDone ? 1 : -1);

    return Column(
      children: [
        if (todosForDay.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('no_tasks').tr(),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: todosForDay.length,
              itemBuilder: (context, index) {
                final todo = todosForDay[index];
                return TodoItem(todo: todo, notifier: notifier);
              },
            ),
          ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('add_task').tr(),
          onPressed: () => _showAddDialog(context, notifier),
        ),
      ],
    );
  }
  /// Wyświetla okno dialogowe do dodawania nowego zadania
  void _showAddDialog(BuildContext context, TodoNotifier notifier) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('new_task').tr(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'title'.tr()),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'description'.tr()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('cancel').tr(),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('title_required').tr()),
                );
                return;
              }
              // Sprawdzenie, czy opis nie jest pusty
              final newTodo = TodoModel(
                id: const Uuid().v4(),
                title: titleController.text.trim(),
                description: descController.text.trim(),
                date: selectedDate,
              );
              notifier.addTodo(newTodo);
              Navigator.of(ctx).pop();
            },
            child: const Text('save').tr(),
          ),
        ],
      ),
    );
  }
}
// Widżet reprezentujący pojedyncze zadanie
class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final TodoNotifier notifier;

  const TodoItem({super.key, required this.todo, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: todo.isDone,
            onChanged: (_) => notifier.toggleTodo(todo.id),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'delete'.tr(),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
    );
  }
  /// Wyświetla okno dialogowe potwierdzające usunięcie zadania
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('confirm_delete').tr(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('cancel').tr(),
          ),
          TextButton(
            onPressed: () {
              notifier.removeTodo(todo.id);
              Navigator.of(ctx).pop();
            },
            child: const Text('delete').tr(),
          ),
        ],
      ),
    );
  }
}