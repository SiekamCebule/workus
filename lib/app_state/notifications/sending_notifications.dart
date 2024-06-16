import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workus/app_state/notifications/notifications.dart';
import 'package:workus/utils/labels.dart';

Future<void> showSessionEndNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'session_end',
    'Session end',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'end_session',
        'Zakończ sesję',
        showsUserInterface: true,
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

Future<void> showShortBreakNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'short_break',
    'Short break',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'end_short_break',
        'Zakończ przerwę',
        showsUserInterface: true,
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
    NotificationIds.shortBreak,
    'Czas na przerwę',
    'Naładuj baterie, a potem do dzieła!',
    const NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> showAfterTickNotification(Duration remainingTime) async {
  const androidDetails = AndroidNotificationDetails(
    'tick',
    'Tick',
    importance: Importance.low,
    priority: Priority.low,
    actions: [
      AndroidNotificationAction(
        'cancel_session',
        'Anuluj sesję',
        showsUserInterface: true,
      ),
    ],
  );
  const linuxDetails = LinuxNotificationDetails(
    transient: true,
    resident: true,
    urgency: LinuxNotificationUrgency.low,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'cancel_session',
        label: 'Anuluj sesję',
      ),
    ],
  );

  final hours = atLeastTwoDigit(remainingTime.inHours);
  final minutes = atLeastTwoDigit(remainingTime.inMinutes.remainder(60));
  final seconds = atLeastTwoDigit(remainingTime.inSeconds.remainder(60));
  final remainingTimeString = '$hours:$minutes:$seconds';

  await notificationsPlugin.show(
    NotificationIds.afterTick,
    'Skup się!',
    'Do końca: $remainingTimeString',
    const NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> cancelNotification(int notificationId) async {
  await notificationsPlugin.cancel(notificationId);
}
