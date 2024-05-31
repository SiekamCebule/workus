import 'package:workus/models/task.dart';
import 'package:workus/utils/collections_filtering.dart';

class TaskStatusesBuilder {
  Map<Task, bool> statuses = {};
  List<Task> tasks = [];

  Map<Task, bool> filledWithFalse(List<Task> keys) {
    return {
      for (var task in keys) task: false,
    };
  }

  Map<Task, bool> rebuilded(Map<Task, bool> oldStatuses, List<Task> newTasks) {
    _updateFields(oldStatuses, newTasks);
    _rebuild();
    _sortByTasksOrderList();
    return statuses;
  }

  void _updateFields(Map<Task, bool> oldStatuses, List<Task> newTasks) {
    statuses = oldStatuses;
    tasks = newTasks;
  }

  void _rebuild() {
    final changedTasks = _changedTasks();
    final newTasks = _newTasks(changedTasks);
    final keptTasks = _keptTasks(changedTasks);
    statuses = {
      for (var changed in changedTasks) changed: false,
      for (var newTask in newTasks) newTask: false,
      for (var kept in keptTasks) kept: statuses[kept]!,
    };
  }

  Iterable<Task> _changedTasks() {
    final changedTasks = <Task>{};
    for (var task in statuses.keys) {
      final equivalent = elementById(tasks, task.id) as Task?;
      if (equivalent != null && task.title != equivalent.title) {
        changedTasks.add(task);
      }
    }
    return changedTasks;
  }

  Iterable<Task> _newTasks(Iterable<Task> changedTasks) {
    return tasks.where((task) {
      return _taskIsNew(changedTasks, task);
    }).toList();
  }

  bool _taskIsNew(Iterable<Task> changedTasks, Task task) =>
      !changedTasks.contains(task) && !statuses.keys.contains(task);

  Iterable<Task> _keptTasks(Iterable<Task> changedTasks) {
    return statuses.keys.where((task) => _taskShouldBeKept(changedTasks, task));
  }

  bool _taskShouldBeKept(Iterable<Task> changedTasks, Task task) =>
      !changedTasks.contains(task) && tasks.contains(task);

  void _sortByTasksOrderList() {
    statuses = {
      for (var task in tasks) task: statuses[task]!,
    };
  }
}
