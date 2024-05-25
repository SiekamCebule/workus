import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';

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

  void update(Task task, bool completed) {
    state = {
      ...state,
      task: completed,
    };
  }

  void fill(List<Task> tasks, bool completed) {
    state = {
      for (var task in tasks) task: completed,
    };
  }
}

final taskBeforeWorkStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(),
);

final taskDuringSmallBreakStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(),
);

final taskAfterWorkStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(),
);
