import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';

class TaskStatusesNotifier extends Notifier<Map<Task, bool>> {
  TaskStatusesNotifier({
    List<Task>? tasks,
  });

  @override
  Map<Task, bool> build() {
    return {};
  }

  void toggle(Task task) {
    state = {
      ...state,
      task: !(state[task] ?? false),
    };
  }

  void update(Task task, {required bool completed}) {
    state = {
      ...state,
      task: completed,
    };
  }

  void fill(List<Task> tasks, {required bool completed}) {
    state = {
      for (var task in tasks) task: completed,
    };
  }

  bool isCompleted(Task task) => state[task]!;
  bool get hasIncompletedTasks => state.values.any((status) => status == false);
}

final taskBeforeWorkStatusesProvider = NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(),
);

final taskDuringSmallBreakStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(),
);

final taskAfterWorkStatusesProvider = NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(),
);

NotifierProvider<TaskStatusesNotifier, Map<Task, bool>> obtainTaskStatusesProviderByType(
    TaskType type) {
  return switch (type) {
    TaskType.beforeSession => taskBeforeWorkStatusesProvider,
    TaskType.duringMiniBreak => taskDuringSmallBreakStatusesProvider,
    TaskType.afterSession => taskAfterWorkStatusesProvider,
  };
}

Map<Task, bool> obtainTaskStatusesByType(WidgetRef ref, TaskType type) {
  final provider = obtainTaskStatusesProviderByType(type);
  return ref.watch(provider);
}
