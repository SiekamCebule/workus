import 'package:flutter/material.dart';
import 'package:workus/ui/layouts/tasks/widgets/about_tasks_button.dart';

class TasksScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Zadania'),
      actions: const [
        AboutTasksButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
