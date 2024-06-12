import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/default_session_timing_configuration_guard.dart';
import 'package:workus/app_state/configuration/loading.dart';
import 'package:workus/app_state/global_session_state/notificating_module.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/app_state/notifications/notifications_sender.dart';
import 'package:workus/app_state/quotes/quotes_provider.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/utils/uuid_gen.dart';

final _initializer = _AppInitializer();

Future<void> initializeAppState(WidgetRef ref) async {
  await _initializer.initialize(ref);
}

Future<void> disposeAppState() async {
  await _initializer.dispose();
}

class _AppInitializer {
  late WidgetRef _ref;
  final defaultSessionTimingConfigurationGuard = DefaultSessionTimingConfigurationGuard();

  Future<void> initialize(WidgetRef ref) async {
    _ref = ref;
    _initializeTasksBeforeWork();
    _initializeTasksDuringMiniBreak();
    _initializeTasksAfterWork();
    await _initializeQuotes();
    await loadSettings(_ref);
    defaultSessionTimingConfigurationGuard.run(_ref);
    _ref.read(appIsInitializedProvider.notifier).state = true;
    setUpNotificationsSender();
  }

  Future<void> dispose() async {
    defaultSessionTimingConfigurationGuard.stop();
    _ref.read(appIsInitializedProvider.notifier).state = false;
  }

  void setUpNotificationsSender() {
    final statsBroadcaster = _ref.read(sessionStatsBroadcasterProvider);
    _ref
        .read(notificationsSenderProvider)
        .setUpForSessionEnds(statsBroadcaster.sessionEnds);
    _ref
        .read(notificationsSenderProvider)
        .setUpForShortBreaks(statsBroadcaster.shortBreaks);
    _ref.read(notificationsSenderProvider).setUpForTicks(statsBroadcaster.ticks);
  }

  Future<void> _initializeQuotes() async {
    await _ref
        .read(buddhistQuotesProvider.notifier)
        .loadFromJson('assets/quotes/buddhist.json');
    await _ref
        .read(humorousQuotesProvider.notifier)
        .loadFromJson('assets/quotes/humorous.json');
    await _ref
        .read(ironicQuotesProvider.notifier)
        .loadFromJson('assets/quotes/ironic.json');
    await _ref
        .read(motivatingQuotesProvider.notifier)
        .loadFromJson('assets/quotes/motivating.json');

    await _ref.read(quotesProvider.notifier).addAllFromProvider(buddhistQuotesProvider);
    await _ref.read(quotesProvider.notifier).addAllFromProvider(ironicQuotesProvider);
    await _ref.read(quotesProvider.notifier).addAllFromProvider(humorousQuotesProvider);
    await _ref.read(quotesProvider.notifier).addAllFromProvider(motivatingQuotesProvider);
  }

  void _initializeTasksBeforeWork() {
    _ref.read(tasksBeforeWorkProvider.notifier).updateAll([
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
    _ref
        .read(taskBeforeWorkStatusesProvider.notifier)
        .fillWithNewTasks(_ref.read(tasksBeforeWorkProvider), completed: false);
  }

  void _initializeTasksDuringMiniBreak() {
    _ref.read(tasksDuringShortBreakProvider.notifier).updateAll([
      Task(
        title: 'Rozluźnić mięśnie oka',
        type: TaskType.duringShortBreak,
        id: uuidV4(),
      ),
    ]);
    _ref
        .read(taskDuringShortBreakStatusesProvider.notifier)
        .fillWithNewTasks(_ref.read(tasksDuringShortBreakProvider), completed: false);
  }

  void _initializeTasksAfterWork() {
    _ref.read(tasksAfterWorkProvider.notifier).updateAll([
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
    _ref
        .read(taskAfterWorkStatusesProvider.notifier)
        .fillWithNewTasks(_ref.read(tasksAfterWorkProvider), completed: false);
  }

  bool get appIsInitialized => _ref.watch(appIsInitializedProvider);
}

final appIsInitializedProvider = StateProvider<bool>((ref) {
  return false;
});
