import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/ui/layouts/tasks/widgets/task_types_segmented_button.dart';
import 'package:workus/ui/layouts/tasks/widgets/tasks_screen_app_bar.dart';
import 'package:workus/ui/layouts/tasks/widgets/tasks_view.dart';

part '__universal.dart';

class AdaptiveTasksScreen extends StatelessWidget {
  const AdaptiveTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final content = switch (LayoutType.fromConstraints(constraints)) {
          _ => ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const _Universal(),
            ),
        };
        return Scaffold(
          appBar: const TasksScreenAppBar(),
          body: Center(
            child: content,
          ),
        );
      },
    );
  }
}
