import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/quotes/quotes_provider.dart';
import 'package:workus/providers/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/providers/tasks_management/tasks.dart';
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
    Future.microtask(() async {
      initializeTasksBeforeWork();
      initializeTasksDuringMiniBreak();
      initializeTasksAfterWork();
      await initializeQuotes();
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

  Future<void> initializeQuotes() async {
    final loadQuotesFromJson = [
      ref
          .read(buddhistQuotesProvider.notifier)
          .loadFromJson('assets/quotes/buddhist.json'),
      ref
          .read(humorousQuotesProvider.notifier)
          .loadFromJson('assets/quotes/humorous.json'),
      ref.read(ironicQuotesProvider.notifier).loadFromJson('assets/quotes/ironic.json'),
      ref
          .read(motivatingQuotesProvider.notifier)
          .loadFromJson('assets/quotes/motivating.json'),
    ];
    await Future.wait(loadQuotesFromJson);
    final initializeQuotesProvider = [
      ref.read(quotesProvider.notifier).addAllFromProvider(buddhistQuotesProvider),
      ref.read(quotesProvider.notifier).addAllFromProvider(ironicQuotesProvider),
      ref.read(quotesProvider.notifier).addAllFromProvider(humorousQuotesProvider),
      ref.read(quotesProvider.notifier).addAllFromProvider(motivatingQuotesProvider),
    ];
    await Future.wait(initializeQuotesProvider);
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
    ref.read(tasksDuringShortBreakProvider.notifier).updateAll([
      Task(
        title: 'Rozluźnić mięśnie oka',
        type: TaskType.duringShortBreak,
        id: uuidV4(),
      ),
    ]);
    ref
        .read(taskDuringShortBreakStatusesProvider.notifier)
        .fill(ref.read(tasksDuringShortBreakProvider), completed: false);
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
