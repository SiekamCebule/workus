import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/ui/layouts/tasks/widgets/about_tasks_button.dart';
import 'package:workus/ui/layouts/tasks/widgets/task_types_segmented_button.dart';
import 'package:workus/ui/layouts/tasks/widgets/tasks_view.dart';

class LargeTasksScreen extends StatelessWidget {
  const LargeTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zadania'),
        actions: const [
          AboutTasksButton(),
        ],
      ),
      body: const Center(
        child: FractionallySizedBox(
          widthFactor: 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              TaskTypesSegmentedButton(),
              Gap(15),
              Expanded(
                flex: 4,
                child: TasksView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
