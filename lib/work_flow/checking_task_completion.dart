import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/task_completion_statuses.dart';

bool incompleteTaskExists(TaskType type, WidgetRef ref) {
  final tasksBeforeWorkProvider = obtainTaskStatusesProviderByType(type);
  return ref.read(tasksBeforeWorkProvider.notifier).hasIncompletedTasks;
}
