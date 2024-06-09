import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/ui/layouts/tasks/widgets/show_about_tasks_dialog.dart';

class AboutTasksButton extends StatelessWidget {
  const AboutTasksButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showAboutTasksDialog(context);
      },
      icon: const Icon(Symbols.help),
    );
  }
}
