import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/task_completion_statuses.dart';
import 'package:workus/ui/pages/work/modes/before_session/task_completion_tile/task_completion_tile.dart';

class TasksToComplete extends ConsumerStatefulWidget {
  const TasksToComplete({
    super.key,
    required this.tasksType,
  });

  final TaskType tasksType;

  @override
  ConsumerState<TasksToComplete> createState() => _TasksToCompleteState();
}

class _TasksToCompleteState extends ConsumerState<TasksToComplete> {
  @override
  Widget build(BuildContext context) {
    final taskStatuses = obtainTaskStatusesByType(ref, widget.tasksType);

    debugPrint([
      Theme.of(context).colorScheme.surfaceContainer,
      Theme.of(context).colorScheme.surfaceContainerLow,
      Theme.of(context).colorScheme.surfaceContainerLowest,
      Theme.of(context).colorScheme.surfaceContainerHigh,
      Theme.of(context).colorScheme.surfaceContainerHighest,
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.surfaceDim,
      Theme.of(context).colorScheme.surfaceBright,
      Theme.of(context).colorScheme.inverseSurface,
    ].toString());

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        children: taskStatuses.keys.map((task) {
          return TaskCompletionTile(task: task);
        }).toList(),
      ),
    );
  }
}
