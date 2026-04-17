class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });

  TodoModel copyWith({bool? isDone}) => TodoModel(
        id: id,
        title: title,
        description: description,
        date: date,
        isDone: isDone ?? this.isDone,
      );

  factory TodoModel.empty() {
    return TodoModel(
      id: '',
      title: '',
      description: '',
      date: DateTime.now(),
      isDone: false,
    );
  }
}