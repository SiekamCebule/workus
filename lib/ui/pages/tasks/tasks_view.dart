import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/errors/too_many_tasks_error.dart';
import 'package:workus/models/task.dart';
import 'package:workus/app_state/constants/constraints.dart';
import 'package:workus/app_state/selected_tasks_type.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/ui/pages/tasks/add_task_button.dart';
import 'package:workus/ui/pages/tasks/task_tile.dart';

class TasksView extends ConsumerWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(selectedTaskTypeProvider);
    final tasks = obtainTasksByType(ref, type);
    final avaiableSlots = maxTasksCountInCategory - tasks.length;
    return Column(
      children: [
        ..._buildTaskTiles(tasks, ref),
        if (avaiableSlots > 0)
          for (var i = 0; i < avaiableSlots; i++)
            AddTaskButton(
              taskNumber: i + 1 + tasks.length,
              taskType: type,
            ),
      ]
          .expand(
            ((widget) => [
                  widget,
                  const Gap(5),
                ]),
          )
          .toList(),
    );
  }

  List<Widget> _buildTaskTiles(List<Task> tasks, WidgetRef ref) {
    if (tasks.length > maxTasksCountInCategory) {
      throw TooManyTasksError(
          'there are too many tasks (${tasks.length} vs limit of $maxTasksCountInCategory) when building task tiles for TasksView');
    }
    return tasks.map(
      (task) {
        return TaskTile(task: task);
      },
    ).toList();
  }
}
