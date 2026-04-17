import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:consvita/models/todo_model.dart';
import 'package:consvita/core/todo_database.dart';

/// Provider bazy danych
final todoDatabaseProvider = Provider<TodoDatabase>((ref) {
  return TodoDatabase();
});

/// Provider zarządzający listą zadań
final todoProvider =
    NotifierProvider<TodoNotifier, List<TodoModel>>(TodoNotifier.new);

class TodoNotifier extends Notifier<List<TodoModel>> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late final TodoDatabase _db;

  @override
  List<TodoModel> build() {
    _db = ref.watch(todoDatabaseProvider);

    _initNotifications();
    _loadTodos();

    return [];
  }

  Future<void> _initNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));

    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidInitSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) {},
    );
  }

  Future<void> _loadTodos() async {
    final todos = await _db.getTodos();
    state = todos;
  }

  Future<void> addTodo(TodoModel todo) async {
    await _db.addTodo(todo);
    state = [...state, todo];
    await _scheduleNotification(todo); // 🔧 await dodany
  }

  Future<void> toggleTodo(String id) async {
    final index = state.indexWhere((t) => t.id == id);

    if (index != -1) {
      final updated = state[index].copyWith(
        isDone: !state[index].isDone,
      );

      await _db.updateTodo(updated);

      final newState = [...state];
      newState[index] = updated;
      state = newState;
    }
  }

  Future<void> removeTodo(String id) async {
    await _db.removeTodo(id);
    state = state.where((t) => t.id != id).toList();
  }

  Future<void> _scheduleNotification(TodoModel todo) async {
    const androidDetails = AndroidNotificationDetails(
      'todo_channel',
      'To-Do Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: todo.hashCode,
      title: 'Zadanie: ${todo.title}',
      body: todo.description,
      scheduledDate: tz.TZDateTime.from(todo.date, tz.local),
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}