import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/ui/layouts/before_session/widgets/task_completion_tile/task_completion_tile.dart';

class TasksToComplete extends ConsumerStatefulWidget {
  const TasksToComplete({
    super.key,
    required this.tasksType,
    this.topPadding,
    this.bottomPadding,
  });

  final TaskType tasksType;
  final double? topPadding;
  final double? bottomPadding;

  @override
  ConsumerState<TasksToComplete> createState() => _TasksToCompleteState();
}

class _TasksToCompleteState extends ConsumerState<TasksToComplete> {
  @override
  Widget build(BuildContext context) {
    final taskStatuses = obtainTaskStatusesByType(ref, widget.tasksType);
    final tiles = taskStatuses.keys.map((task) {
      return TaskCompletionTile(
        key: ValueKey(task.id),
        task: task,
      );
    });

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          if (widget.topPadding != null)
            Padding(
              padding: EdgeInsets.only(top: widget.topPadding!),
            ),
          ...tiles,
          if (widget.bottomPadding != null)
            Padding(
              padding: EdgeInsets.only(bottom: widget.bottomPadding!),
            ),
        ],
      ),
    );
  }
}
