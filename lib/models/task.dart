import 'package:workus/models/task_type.dart';

class Task {
  const Task({
    required this.title,
    required this.type,
    required this.id,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] as String,
      type: TaskType.values.firstWhere((e) => e.name == json['type']),
      id: json['id'],
    );
  }

  final Object id;
  final String title;
  final TaskType type;

  Task copyWith({
    String? title,
    TaskType? type,
    Object? id,
  }) {
    return Task(
      title: title ?? this.title,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant Task other) {
    return title == other.title && type == other.type && id == other.id;
  }

  @override
  String toString() {
    return '$title (${type.name})';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type.name,
      'id': id,
    };
  }
}
