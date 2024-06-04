import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/ui/pages/tasks/about_tasks_button.dart';
import 'package:workus/ui/pages/tasks/task_types_segmented_button.dart';
import 'package:workus/ui/pages/tasks/tasks_view.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zadania'),
        actions: const [
          AboutTasksButton(),
        ],
      ),
      body: const Column(
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
    );
  }
}
