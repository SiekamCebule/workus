import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/default_session_timing_configuration_guard.dart';
import 'package:workus/app_state/configuration/loading.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/global_session_state/notificating_module.dart';
import 'package:workus/app_state/notifications/notification_responses_handling.dart';
import 'package:workus/app_state/notifications/notifications.dart';
import 'package:workus/app_state/quotes/quotes_provider.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/app_state/tasks_management/tasks.dart';
import 'package:workus/models/task.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/utils/uuid_gen.dart';

final _initializer = _AppInitializer();

Future<void> initializeAppState(BuildContext context, WidgetRef ref) async {
  await _initializer.initialize(context, ref);
}

Future<void> disposeAppState() async {
  await _initializer.dispose();
}

class _AppInitializer {
  late BuildContext _context;
  late WidgetRef _ref;
  final defaultSessionTimingConfigurationGuard = DefaultSessionTimingConfigurationGuard();
  late ProviderSubscription<bool> showNotificationProviderChangesSubscription;

  Future<void> initialize(BuildContext context, WidgetRef ref) async {
    _context = context;
    _ref = ref;
    _initializeTasksBeforeWork();
    _initializeTasksDuringMiniBreak();
    _initializeTasksAfterWork();
    if (!_context.mounted) return;
    await loadSettings(_context, _ref);
    await _initializeQuotes();
    defaultSessionTimingConfigurationGuard.run(_ref);
    _ref.read(appIsInitializedProvider.notifier).state = true;
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _initializeForTesting();
    }
    _ensureNotificationsPermission();
    _runNotificationsPermissionGuard();
    _setUpNotificationHandling();
    _setUpNotificationsSender();
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

  Future<void> _initializeQuotes() async {
    final selectedLangCode = _ref.read(languageProvider).code;
    await _ref
        .read(quotesProvider.notifier)
        .loadFromJson('assets/quotes/$selectedLangCode.json');
  }

  void _initializeForTesting() {
    _ref.read(shouldShowNotificationsProvider.notifier).state = false;
    _ref.read(enableAlarmsProvider.notifier).state = false;
  }

  void _ensureNotificationsPermission() {
    if (_ref.read(shouldShowNotificationsProvider)) {
      maybeRequestForNotificationsPermissions();
    }
  }

  void _runNotificationsPermissionGuard() {
    showNotificationProviderChangesSubscription =
        _ref.listenManual(shouldShowNotificationsProvider, (previous, current) {
      if (current == true) {
        maybeRequestForNotificationsPermissions();
      }
    });
  }

  void _setUpNotificationHandling() {
    notificationResponseCallbacksRegistrar.register((responseDetails) {
      handleNotificationReponse(responseDetails, _ref);
    });
  }

  void _setUpNotificationsSender() {
    _ref.read(notificationsSenderProvider).setUp(_context, _ref);
  }

  Future<void> dispose() async {
    defaultSessionTimingConfigurationGuard.stop();
    _ref.read(appIsInitializedProvider.notifier).state = false;
    _ref.read(notificationsSenderProvider).tearDown();
    showNotificationProviderChangesSubscription.close();
  }

  bool get appIsInitialized => _ref.watch(appIsInitializedProvider);
}

final appIsInitializedProvider = StateProvider<bool>((ref) {
  return false;
});
