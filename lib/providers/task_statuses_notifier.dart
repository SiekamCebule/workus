import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/tasks.dart';

class TaskStatusesNotifier extends Notifier<Map<Task, bool>> {
  TaskStatusesNotifier({
    List<Task>? tasks,
    required this.taskType,
  });

  TaskType taskType;

  Map<Task, bool>? _statuses;
  set statuses(Map<Task, bool> other) {
    _statuses = other;
  }

  void syncStatuses() {
    _statuses = state;
  }

  @override
  Map<Task, bool> build() {
    List<Task> tasks = ref.watch(obtainTasksProviderByType(taskType));

    if (_statuses == null) {
      statuses = _fillWithFalse(tasks);
      return _statuses!;
    } else {
      statuses = _rebuildStatuses(tasks);
      return _statuses!;
    }
  }

  Map<Task, bool> _fillWithFalse(List<Task> tasks) {
    return {for (var task in tasks) task: false};
  }

  Map<Task, bool> _rebuildStatuses(List<Task> tasks) {
    final changedTasks = _changedTasks(tasks);
    final rebuilded = {
      for (var keptTask in _statuses!.keys)
        if (!changedTasks.contains(keptTask)) keptTask: _statuses![keptTask]!,
      for (var changedTask in changedTasks) _taskById(tasks, changedTask.id): false,
    };
    return _sortStatuses(rebuilded, tasks);
  }

  Map<Task, bool> _sortStatuses(Map<Task, bool> statuses, List<Task> tasksOrder) {
    return {
      for (var task in tasksOrder) task: statuses[task]!,
    };
  }

  Set<Task> _changedTasks(List<Task> tasks) {
    final changedTasks = <Task>{};
    for (var task in _statuses!.keys) {
      if (task.title != _taskById(tasks, task.id).title) {
        changedTasks.add(task);
      }
    }
    return changedTasks;
  }

  Task _taskById(Iterable<Task> tasks, Object id) {
    return tasks.firstWhere((task) => task.id == id);
  }

  void toggle(Task task) {
    state = {
      ...state,
      task: !(state[task] ?? false),
    };
    syncStatuses();
  }

  void update(Task task, {required bool completed}) {
    state = {
      ...state,
      task: completed,
    };
    syncStatuses();
  }

  void fill(List<Task> tasks, {required bool completed}) {
    state = {
      for (var task in tasks) task: completed,
    };
    syncStatuses();
  }

  bool isCompleted(Task task) => state[task]!;
  bool get incompletedTaskExists => state.values.any((status) => status == false);
}

final taskBeforeWorkStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(taskType: TaskType.beforeSession),
);

final taskDuringSmallBreakStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(taskType: TaskType.duringSmallBreak),
);

final taskAfterWorkStatusesProvider =
    NotifierProvider<TaskStatusesNotifier, Map<Task, bool>>(
  () => TaskStatusesNotifier(taskType: TaskType.afterSession),
);

NotifierProvider<TaskStatusesNotifier, Map<Task, bool>> obtainTaskStatusesProviderByType(
    TaskType type) {
  return switch (type) {
    TaskType.beforeSession => taskBeforeWorkStatusesProvider,
    TaskType.duringSmallBreak => taskDuringSmallBreakStatusesProvider,
    TaskType.afterSession => taskAfterWorkStatusesProvider,
  };
}

Map<Task, bool> obtainTaskStatusesByType(WidgetRef ref, TaskType type) {
  final provider = obtainTaskStatusesProviderByType(type);
  return ref.watch(provider);
}
