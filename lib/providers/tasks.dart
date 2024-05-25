import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';

class TasksNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() {
    return [];
  }

  void updateAll(List<Task> tasks) {
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
}

final tasksBeforeWorkProvider = NotifierProvider<TasksNotifier, List<Task>>(
  () => TasksNotifier(),
);

final tasksDuringSmallBreakProvider =
    NotifierProvider<TasksNotifier, List<Task>>(
  () => TasksNotifier(),
);

final tasksAfterWorkProvider = NotifierProvider<TasksNotifier, List<Task>>(
  () => TasksNotifier(),
);

NotifierProvider<TasksNotifier, List<Task>> obtainTasksProviderByType(
    WidgetRef ref, TaskType type) {
  return switch (type) {
    TaskType.beforeWork => tasksBeforeWorkProvider,
    TaskType.duringMiniBreak => tasksDuringSmallBreakProvider,
    TaskType.afterWork => tasksAfterWorkProvider,
  };
}

List<Task> obtainTasksByType(WidgetRef ref, TaskType type) {
  return switch (type) {
    TaskType.beforeWork => ref.watch(tasksBeforeWorkProvider),
    TaskType.duringMiniBreak => ref.watch(tasksDuringSmallBreakProvider),
    TaskType.afterWork => ref.watch(tasksAfterWorkProvider),
  };
}

void debugTasks(WidgetRef ref) {
  debugPrint('beforeWork: ${ref.read(tasksBeforeWorkProvider)}');
  debugPrint('duringMiniBreak: ${ref.read(tasksDuringSmallBreakProvider)}');
  debugPrint('afterWork: ${ref.read(tasksAfterWorkProvider)}');
}
