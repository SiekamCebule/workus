import 'package:workus/models/task_type.dart';

class Task {
  Task({
    required this.title,
    required this.type,
    required this.id,
  });

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
    assert(!_sameButOtherIds(other));
    return title == other.title && type == other.type && id == other.id;
  }

  bool _sameButOtherIds(Task other) {
    return title == other.title && type == other.type && id != other.id;
  }

  Object id;
  String title;
  TaskType type;

  @override
  String toString() {
    return '$title (${type.name})';
  }
}
