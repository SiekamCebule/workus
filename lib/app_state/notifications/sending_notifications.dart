import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workus/app_state/notifications/notifications.dart';

Future<void> sendSessionEndNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'end_session',
        'Zakończ sesję',
      ),
    ],
  );
  const linuxDetails = LinuxNotificationDetails(
    urgency: LinuxNotificationUrgency.normal,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'end_session',
        label: 'Zakończ sesję',
      ),
    ],
  );

  await notificationsPlugin.show(
    NotificationIds.afterWork,
    'Koniec pracy',
    'Gratulujemy wytrwałości',
    const NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> sendShortBreakNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'end_short_break',
        'Zakończ przerwę',
      ),
    ],
  );
  const linuxDetails = LinuxNotificationDetails(
    urgency: LinuxNotificationUrgency.normal,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'end_short_break',
        label: 'Zakończ przerwę',
      ),
    ],
  );

  await notificationsPlugin.show(
    NotificationIds.afterWork,
    'Czas na przerwę',
    'Naładuj baterię, a potem do dzieła!',
    const NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> sendAfterTickNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'cancel_session',
        'Anuluj sesję',
      ),
    ],
  );
  const linuxDetails = LinuxNotificationDetails(
    urgency: LinuxNotificationUrgency.normal,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'cancel_session',
        label: 'Anuluj sesję',
      ),
    ],
  );

  await notificationsPlugin.show(
    NotificationIds.afterWork,
    'Skup się!',
    'Zostało X czasu do końca sesji',
    const NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}
