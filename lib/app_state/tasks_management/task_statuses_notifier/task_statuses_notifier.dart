import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_builder.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';

class TaskStatusesNotifier extends Notifier<Map<Task, bool>> {
  TaskStatusesNotifier({
    required this.tasksProvider,
    List<Task>? tasks,
  });

  final NotifierProvider<TasksNotifier, List<Task>> tasksProvider;

  final _builder = TaskStatusesBuilder();
  Map<Task, bool>? _statuses;
  set statuses(Map<Task, bool> other) {
    _statuses = other;
  }

  void _syncStatuses() {
    _statuses = state;
  }

  @override
  Map<Task, bool> build() {
    List<Task> tasks = ref.watch(tasksProvider);

    if (_statuses == null) {
      statuses = _builder.filledWithFalse(tasks);
      return _statuses!;
    } else {
      statuses = _builder.rebuilded(_statuses!, tasks);
      return _statuses!;
    }
  }

  void toggle(Task task) {
    state = {
      ...state,
      task: !(state[task] ?? false),
    };
    _syncStatuses();
  }

  void update(Task task, {required bool completed}) {
    state = {
      ...state,
      task: completed,
    };
    _syncStatuses();
  }

  void fillWithNewTasks(List<Task> tasks, {required bool completed}) {
    state = {
      for (var task in tasks) task: completed,
    };
    _syncStatuses();
  }

  void fillCurrent({required bool completed}) {
    state = {
      for (var task in state.keys) task: completed,
    };
    _syncStatuses();
  }

  bool isCompleted(Task task) => state[task]!;
  bool get incompletedTaskExists => state.values.any((status) => status == false);
}

final taskBeforeWorkStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(tasksProvider: tasksBeforeWorkProvider),
);

final taskDuringShortBreakStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(tasksProvider: tasksDuringShortBreakProvider),
);

final taskAfterWorkStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(tasksProvider: tasksAfterWorkProvider),
);

NotifierProvider<TaskStatusesNotifier, Map<Task, bool>> obtainTaskStatusesProviderByType(
    TaskType type) {
  return switch (type) {
    TaskType.beforeSession => taskBeforeWorkStatusesProvider,
    TaskType.duringShortBreak => taskDuringShortBreakStatusesProvider,
    TaskType.afterSession => taskAfterWorkStatusesProvider,
  };
}

Map<Task, bool> obtainTaskStatusesByType(WidgetRef ref, TaskType type) {
  final provider = obtainTaskStatusesProviderByType(type);
  return ref.watch(provider);
}
