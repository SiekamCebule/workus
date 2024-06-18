import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract final class NotificationIds {
  static const int afterWork = 0;
  static const int shortBreak = 1;
  static const int afterTick = 2;
}

final notificationsPlugin = FlutterLocalNotificationsPlugin();

const notificationsPluginInitializationSettings = InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  linux: LinuxInitializationSettings(defaultActionName: 'default_action_name'),
);

Future<bool?> maybeRequestForNotificationsPermissions() async {
  return notificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}
