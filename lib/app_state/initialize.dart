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
import 'package:workus/app_state/tasks_management/loading.dart';

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
    _initializeFields(context, ref);
    await _loadSettings(context);
    if (context.mounted) await _loadTasks(context);
    await _initializeQuotes();
    _runDefaultSessionTimingConfigurationGuard();
    _markAppAsInitialized();
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _initializeForTesting();
    }
    _ensureNotificationsPermission();
    _runNotificationsPermissionGuard();
    _setUpNotificationHandling();
    _setUpNotificationsSender();
  }

  Future<void> _loadSettings(BuildContext context) async {
    if (context.mounted) {
      await loadSettings(_context, _ref);
    }
  }

  Future<void> _loadTasks(BuildContext context) async {
    await loadAllTasks(_ref);
  }

  void _runDefaultSessionTimingConfigurationGuard() {
    defaultSessionTimingConfigurationGuard.run(_ref);
  }

  void _markAppAsInitialized() {
    _ref.read(appIsInitializedProvider.notifier).state = true;
  }

  void _initializeFields(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;
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
