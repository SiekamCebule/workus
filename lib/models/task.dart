import 'package:workus/models/task_type.dart';

class Task {
  Task(this.title, this.type);

  Task copyWith({
    String? title,
    TaskType? type,
  }) {
    return Task(title ?? this.title, type ?? this.type);
  }

  String title;
  TaskType type;

  @override
  String toString() {
    return '$title (${type.name})';
  }
}
