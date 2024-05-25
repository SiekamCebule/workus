import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/task_completion_statuses.dart';
import 'package:workus/providers/tasks.dart';
import 'package:workus/ui/main_scaffold/main_page_view.dart';
import 'package:workus/ui/main_scaffold/main_scaffold_navbar.dart';

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
      Task('Zrobić 8 przysiadów', TaskType.beforeWork),
      Task('Wykonać ćwiczenie z długopisem', TaskType.beforeWork),
    ]);
    ref
        .read(taskBeforeWorkStatusesProvider.notifier)
        .fill(ref.read(tasksBeforeWorkProvider), false);
  }

  void initializeTasksDuringMiniBreak() {
    ref.read(tasksDuringSmallBreakProvider.notifier).updateAll([
      Task('Spojrzenie w górę (30 sekund)', TaskType.duringMiniBreak),
      Task('Horyzont za oknem (30 sekund)', TaskType.duringMiniBreak),
    ]);
    ref
        .read(taskDuringSmallBreakStatusesProvider.notifier)
        .fill(ref.read(tasksDuringSmallBreakProvider), false);
  }

  void initializeTasksAfterWork() {
    ref.read(tasksAfterWorkProvider.notifier).updateAll([
      Task('Uśmiechnąć się', TaskType.afterWork),
      Task('Zjeść kostkę czekolady', TaskType.afterWork),
      Task('Wziąć dwa łyki wody', TaskType.afterWork),
    ]);
    ref.read(taskAfterWorkStatusesProvider.notifier).fill(ref.read(tasksAfterWorkProvider), false);
  }
}
