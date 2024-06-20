import 'package:workus/models/task.dart';

Map<String, dynamic> serializeTasksToJson(Iterable<Task> tasks) {
  return {
    'tasks': tasks
        .map(
          (task) => task.toJson(),
        )
        .toList(),
  };
}

Iterable<Task> parseTasksFromJson(Map<String, dynamic> json) {
  Iterable tasksJson = json['tasks'];
  return tasksJson.map(
    (taskJson) => Task.fromJson(taskJson),
  );
}
