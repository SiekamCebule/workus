import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/defaults.dart';
import 'package:workus/providers/tasks.dart';

class AddTaskButton extends ConsumerWidget {
  const AddTaskButton({
    super.key,
    required this.taskNumber,
    required this.taskType,
  });

  final int taskNumber;
  final TaskType taskType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => addTask(ref),
      child: Text('Dodaj zadanie #$taskNumber'),
    );
  }

  void addTask(WidgetRef ref) {
    debugPrint('adding the default task');
    debugTasks(ref);
    final provider = obtainTasksProviderByType(taskType);
    final name = ref.read(defaultNewTaskName);
    ref.read(provider.notifier).add(Task(name, taskType));
  }
}
