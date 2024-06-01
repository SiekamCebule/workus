import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/providers/tasks_management/tasks.dart';

class TaskTileTextField extends ConsumerStatefulWidget {
  const TaskTileTextField({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  ConsumerState<TaskTileTextField> createState() => _TaskTileTextFieldState();
}

class _TaskTileTextFieldState extends ConsumerState<TaskTileTextField> {
  final controller = TextEditingController();

  @override
  void initState() {
    updateTextInField();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskTileTextField oldWidget) {
    if (oldWidget.task != widget.task) {
      updateTextInField();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (newText) {
        final type = widget.task.type;
        final provider = obtainTasksProviderByType(type);
        ref.read(provider.notifier).update(
              widget.task,
              widget.task.copyWith(title: newText),
            );
      },
    );
  }

  void updateTextInField() {
    controller.text = widget.task.title;
  }
}
