import 'package:flutter/material.dart';
import '../../../models/todo_model.dart';
import '../../../providers/todo_provider.dart';
import 'package:easy_localization/easy_localization.dart';

/// Element listy zadań
class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final TodoNotifier notifier;

  const TodoItem({
    super.key,
    required this.todo,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Zakończ zadanie
          Checkbox(
            value: todo.isDone,
            onChanged: (_) => notifier.toggleTodo(todo.id),
          ),
          /// Usuń zadanie
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'delete'.tr(),
            onPressed: () => notifier.removeTodo(todo.id),
          ),
        ],
      ),
    );
  }
}
