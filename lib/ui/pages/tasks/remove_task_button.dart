import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/models/task.dart';
import 'package:workus/providers/tasks.dart';

class RemoveTaskButton extends ConsumerWidget {
  const RemoveTaskButton({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton.filledTonal(
      onPressed: () => removeTask(ref),
      icon: const Icon(Symbols.delete),
    );
  }

  void removeTask(WidgetRef ref) {
    debugPrint('removing the ($task)');
    debugTasks(ref);
    final type = task.type;
    final provider = obtainTasksProviderByType(ref, type);
    ref.read(provider.notifier).remove(task);
  }
}
