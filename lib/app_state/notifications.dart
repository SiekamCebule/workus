import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract final class NotificationIds {
  static const int sessionEnd = 0;
  static const int shortBreak = 1;
  static const int remainingTime = 2;
}

final notificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeNotificationsPlugin() {
  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    linux: LinuxInitializationSettings(defaultActionName: 'default_action_name'),
  );
  notificationsPlugin.initialize(initializationSettings);
}

Future<bool?> maybeRequestForNotificationsPermissions() async {
  return notificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

Future<void> sendSessionEndNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'go_to_app',
        'Przejdź do aplikacji',
      ),
      AndroidNotificationAction(
        'end_session',
        'Zakończ sesję',
      ),
    ],
  );
  const linuxDetails = LinuxNotificationDetails(
    urgency: LinuxNotificationUrgency.critical,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'go_to_app',
        label: 'Przejdź do aplikacji',
      ),
      LinuxNotificationAction(
        key: 'end_session',
        label: 'Zakończ sesję',
      ),
    ],
  );

  await notificationsPlugin.show(
    NotificationIds.sessionEnd,
    'Koniec pracy',
    'Gratulujemy wytrwałości',
    const NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}
