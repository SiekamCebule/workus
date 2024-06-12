import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/notifications/handling_responses.dart';

abstract final class NotificationIds {
  static const int afterWork = 0;
  static const int shortBreak = 1;
  static const int afterTick = 2;
}

final notificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeNotificationsPlugin(WidgetRef ref) {
  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    linux: LinuxInitializationSettings(defaultActionName: 'default_action_name'),
  );
  notificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      NotificationResponsesHandler().handle(details, ref);
    },
  );
}

Future<bool?> maybeRequestForNotificationsPermissions() async {
  return notificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}
