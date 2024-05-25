import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksToComplete extends ConsumerStatefulWidget {
  const TasksToComplete({super.key});

  @override
  ConsumerState<TasksToComplete> createState() => _TasksToCompleteState();
}

class _TasksToCompleteState extends ConsumerState<TasksToComplete> {
  @override
  Widget build(BuildContext context) {
    print([
      Theme.of(context).colorScheme.surfaceContainer,
      Theme.of(context).colorScheme.surfaceContainerLow,
      Theme.of(context).colorScheme.surfaceContainerLowest,
      Theme.of(context).colorScheme.surfaceContainerHigh,
      Theme.of(context).colorScheme.surfaceContainerHighest,
      Theme.of(context).colorScheme.surface,
    ]);
    return Container(
      height: 100,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}
