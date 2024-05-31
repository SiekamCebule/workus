import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/task_statuse_notifier/task_statuses_notifier.dart';
import 'package:workus/providers/tasks.dart';
import 'package:workus/ui/main_scaffold/main_page_view.dart';
import 'package:workus/ui/main_scaffold/main_scaffold_navbar.dart';
import 'package:workus/utils/uuid_gen.dart';

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  @override
  void initState() {
    Future.microtask(() {
      initializeTasksBeforeWork();
      initializeTasksDuringMiniBreak();
      initializeTasksAfterWork();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainPageView(),
      bottomNavigationBar: MainScaffoldNavbar(),
    );
  }

  void initializeTasksBeforeWork() {
    ref.read(tasksBeforeWorkProvider.notifier).updateAll([
      Task(
        title: 'Zrobić 10 przysiadów',
        type: TaskType.beforeSession,
        id: uuidV4(),
      ),
      Task(
        title: 'Wykonać ćwiczenie na skupienie',
        type: TaskType.beforeSession,
        id: uuidV4(),
      ),
    ]);
    ref
        .read(taskBeforeWorkStatusesProvider.notifier)
        .fill(ref.read(tasksBeforeWorkProvider), completed: false);
  }

  void initializeTasksDuringMiniBreak() {
    ref.read(tasksDuringSmallBreakProvider.notifier).updateAll([
      Task(
        title: 'Rozluźnić mięśnie oka',
        type: TaskType.duringSmallBreak,
        id: uuidV4(),
      ),
    ]);
    ref
        .read(taskDuringSmallBreakStatusesProvider.notifier)
        .fill(ref.read(tasksDuringSmallBreakProvider), completed: false);
  }

  void initializeTasksAfterWork() {
    ref.read(tasksAfterWorkProvider.notifier).updateAll([
      Task(
        title: 'Uśmiechnąć się',
        type: TaskType.afterSession,
        id: uuidV4(),
      ),
      Task(
        title: 'Zrobić 4 pajacyki',
        type: TaskType.afterSession,
        id: uuidV4(),
      ),
    ]);
    ref
        .read(taskAfterWorkStatusesProvider.notifier)
        .fill(ref.read(tasksAfterWorkProvider), completed: false);
  }
}
