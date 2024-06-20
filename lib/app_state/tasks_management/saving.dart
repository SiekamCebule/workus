import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/tasks_management/path.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/app_state/tasks_management/tasks_list_json.dart';
import 'package:workus/models/task_type.dart';

Future<void> saveTasksByType(TaskType type, WidgetRef ref) async {
  final path = await tasksPath(type);
  var file = File(path)..createSync(recursive: true);
  final tasks = obtainTasksByType(ref, type);
  const encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(serializeTasksToJson(tasks));
  file.writeAsStringSync(jsonString);
}

Future<void> saveAllTasks(WidgetRef ref) async {
  for (var type in TaskType.values) {
    await saveTasksByType(type, ref);
  }
}
