import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/models/task.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/ui/layouts/before_session/widgets/task_completion_tile/cross_out_painter.dart';

part '__icon.dart';
part '__task_title.dart';
part '__faded_text.dart';

class TaskCompletionTile extends ConsumerWidget {
  const TaskCompletionTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskStatusesProvider = obtainTaskStatusesProviderByType(task.type);
    final isCompleted = ref.watch(taskStatusesProvider.notifier).isCompleted(task);
    return ListTile(
      title: _TaskTitle(
        taskContent: task.title,
        taskCompleted: isCompleted,
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton.filledTonal(
          onPressed: () {
            ref.watch(taskStatusesProvider.notifier).toggle(task);
          },
          icon: _Icon(
            task: task,
            completed: isCompleted,
          ),
        ),
      ),
    );
  }
}
