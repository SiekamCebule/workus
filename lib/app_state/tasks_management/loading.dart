import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/tasks_management/path.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/app_state/tasks_management/tasks_list_json.dart';
import 'package:workus/models/task_type.dart';

Future<void> loadTasksByType(TaskType type, WidgetRef ref) async {
  final path = await tasksPath(type);
  final file = File(path);
  try {
    final stringContent = await file.readAsString();
    final tasksList = parseTasksFromJson(jsonDecode(stringContent));
    ref.read(obtainTasksProviderByType(type).notifier).updateAll(tasksList);
  } on PathNotFoundException catch (e) {
    debugPrint('Path ${e.path} not found, so cannot load tasks by $type type');
  }
}

Future<void> loadAllTasks(WidgetRef ref) async {
  for (var type in TaskType.values) {
    await loadTasksByType(type, ref);
  }
}
