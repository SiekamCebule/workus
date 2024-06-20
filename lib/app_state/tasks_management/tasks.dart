import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';

class TasksNotifier extends Notifier<Iterable<Task>> {
  @override
  Iterable<Task> build() {
    return [];
  }

  void updateAll(Iterable<Task> tasks) {
    state = tasks;
  }

  void update(Task oldTask, Task newTask) {
    state = [
      for (var task in state)
        if (task == oldTask) newTask else task
    ];
  }

  void add(Task task) {
    state = [...state, task];
  }

  void remove(Task toRemove) {
    state = state.where((task) => task != toRemove).toList();
  }

  int get length => state.length;
  Task byId(Object id) => state.singleWhere((task) => task.id == id);
}

final tasksBeforeWorkProvider = NotifierProvider<TasksNotifier, Iterable<Task>>(
  () => TasksNotifier(),
);

final tasksDuringShortBreakProvider = NotifierProvider<TasksNotifier, Iterable<Task>>(
  () => TasksNotifier(),
);

final tasksAfterWorkProvider = NotifierProvider<TasksNotifier, Iterable<Task>>(
  () => TasksNotifier(),
);

NotifierProvider<TasksNotifier, Iterable<Task>> obtainTasksProviderByType(TaskType type) {
  return switch (type) {
    TaskType.beforeSession => tasksBeforeWorkProvider,
    TaskType.duringShortBreak => tasksDuringShortBreakProvider,
    TaskType.afterSession => tasksAfterWorkProvider,
  };
}

Iterable<Task> obtainTasksByType(WidgetRef ref, TaskType type) {
  final provider = obtainTasksProviderByType(type);
  return ref.watch(provider);
}

void debugTasks(WidgetRef ref) {
  debugPrint('beforeWork: ${ref.read(tasksBeforeWorkProvider)}');
  debugPrint('duringMiniBreak: ${ref.read(tasksDuringShortBreakProvider)}');
  debugPrint('afterWork: ${ref.read(tasksAfterWorkProvider)}');
}
