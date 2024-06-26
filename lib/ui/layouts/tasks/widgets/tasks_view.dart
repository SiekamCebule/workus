import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/errors/too_many_tasks_error.dart';
import 'package:workus/models/task.dart';
import 'package:workus/app_state/constants/constraints.dart';
import 'package:workus/app_state/selected_tasks_type.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/ui/layouts/tasks/widgets/add_task_button.dart';
import 'package:workus/ui/layouts/tasks/widgets/task_tile.dart';

class TasksView extends ConsumerWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(selectedTaskTypeProvider);
    final tasks = obtainTasksByType(ref, type);
    final avaiableSlots = maxTasksCountInCategory - tasks.length;
    return SingleChildScrollView(
      child: Column(children: [
        ..._buildTaskTiles(tasks, ref),
        const Gap(5),
        if (avaiableSlots > 0)
          AddTaskButton(
            taskNumber: maxTasksCountInCategory - avaiableSlots + 1,
            taskType: type,
          ),
        const Gap(5)
      ]),
    );
  }

  Iterable<Widget> _buildTaskTiles(Iterable<Task> tasks, WidgetRef ref) {
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
