import 'package:flutter/material.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/ui/layouts/tasks/large_tasks_screen.dart';
import 'package:workus/ui/layouts/tasks/small_tasks_screen.dart';

class AdaptiveTasksScreen extends StatelessWidget {
  const AdaptiveTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return switch (LayoutType.fromWidth(constraints.maxWidth)) {
          LayoutType.small => const SmallTasksScreen(),
          LayoutType.medium => const LargeTasksScreen(),
          LayoutType.large => const LargeTasksScreen(),
        };
      },
    );
  }
}
