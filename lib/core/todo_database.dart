import 'package:consvita/models/todo_model.dart';

/// lokalna baza danych (do testów)
class TodoDatabase {
  final List<TodoModel> _storage = [];

  Future<List<TodoModel>> getTodos() async {
    return _storage;
  }

  Future<void> addTodo(TodoModel todo) async {
    _storage.add(todo);
  }

  Future<void> removeTodo(String id) async {
    _storage.removeWhere((t) => t.id == id);
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final index = _storage.indexWhere((t) => t.id == updatedTodo.id);
    if (index != -1) _storage[index] = updatedTodo;
  }
}