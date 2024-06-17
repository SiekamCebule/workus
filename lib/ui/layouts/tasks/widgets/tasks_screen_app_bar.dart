import 'package:flutter/material.dart';
import 'package:workus/ui/layouts/tasks/widgets/about_tasks_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TasksScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.tasks),
      actions: const [
        AboutTasksButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
