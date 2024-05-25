import 'package:flutter/material.dart';
import 'package:workus/models/task.dart';
import 'package:workus/ui/pages/tasks/remove_task_button.dart';
import 'package:workus/ui/pages/tasks/task_tile_text_field.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TaskTileTextField(task: task),
      trailing: RemoveTaskButton(
        task: task,
      ),
    );
  }
}
