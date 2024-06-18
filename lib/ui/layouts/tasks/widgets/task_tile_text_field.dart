import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';

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
  var textLength = 0;

  @override
  void initState() {
    controller.addListener(() {
      int lengthDifference = (controller.text.length - textLength).abs();
      textLength = controller.text.length;
      if (lengthDifference > 2) {
        Future.microtask(() async {
          _submitTask();
        });
      }
    });

    _updateTextInField();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskTileTextField oldWidget) {
    if (oldWidget.task != widget.task) {
      _updateTextInField();
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
      onSubmitted: (value) {
        _submitTask();
      },
      onTapOutside: (event) {
        _submitTask();
      },
    );
  }

  void _submitTask() {
    final type = widget.task.type;
    final provider = obtainTasksProviderByType(type);
    ref.read(provider.notifier).update(
          widget.task,
          widget.task.copyWith(title: controller.text),
        );
  }

  void _updateTextInField() {
    controller.text = widget.task.title;
  }
}
