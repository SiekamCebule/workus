import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/utils/uuid_gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      onPressed: () => addTask(context, ref),
      child: Text(AppLocalizations.of(context)!.addTask(taskNumber)),
    );
  }

  void addTask(BuildContext context, WidgetRef ref) {
    final provider = obtainTasksProviderByType(taskType);
    final name = AppLocalizations.of(context)!.newTask;
    ref.read(provider.notifier).add(Task(title: name, type: taskType, id: uuidV4()));
  }
}
