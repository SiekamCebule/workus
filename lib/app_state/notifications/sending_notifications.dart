import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workus/app_state/notifications/notifications.dart';
import 'package:workus/utils/labels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showSessionEndNotification(BuildContext context) async {
  final androidDetails = AndroidNotificationDetails(
    'session_end',
    'Session end',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'end_session',
        AppLocalizations.of(context)!.endSessionConfirm,
        showsUserInterface: true,
      ),
    ],
  );
  final linuxDetails = LinuxNotificationDetails(
    urgency: LinuxNotificationUrgency.normal,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'end_session',
        label: AppLocalizations.of(context)!.endSessionConfirm,
      ),
    ],
  );

  await notificationsPlugin.show(
    NotificationIds.afterWork,
    AppLocalizations.of(context)!.workEnd,
    AppLocalizations.of(context)!.congratulationsAfterWork,
    NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> showShortBreakNotification(BuildContext context) async {
  final androidDetails = AndroidNotificationDetails(
    'short_break',
    'Short break',
    importance: Importance.high,
    priority: Priority.high,
    actions: [
      AndroidNotificationAction(
        'end_short_break',
        AppLocalizations.of(context)!.endBreak,
        showsUserInterface: true,
      ),
    ],
  );
  final linuxDetails = LinuxNotificationDetails(
    urgency: LinuxNotificationUrgency.normal,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'end_short_break',
        label: AppLocalizations.of(context)!.endBreak,
      ),
    ],
  );

  await notificationsPlugin.show(
    NotificationIds.shortBreak,
    AppLocalizations.of(context)!.timeForBreak,
    AppLocalizations.of(context)!.chargeBatteries,
    NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> showAfterTickNotification(
    BuildContext context, Duration remainingTime) async {
  final androidDetails = AndroidNotificationDetails(
    'tick',
    'Tick',
    importance: Importance.low,
    priority: Priority.low,
    actions: [
      AndroidNotificationAction(
        'cancel_session',
        AppLocalizations.of(context)!.cancelSessionConfirm,
        showsUserInterface: true,
      ),
    ],
  );
  final linuxDetails = LinuxNotificationDetails(
    transient: true,
    resident: true,
    urgency: LinuxNotificationUrgency.low,
    category: LinuxNotificationCategory.imReceived,
    actions: [
      LinuxNotificationAction(
        key: 'cancel_session',
        label: AppLocalizations.of(context)!.cancelSessionConfirm,
      ),
    ],
  );

  final hours = atLeastTwoDigit(remainingTime.inHours);
  final minutes = atLeastTwoDigit(remainingTime.inMinutes.remainder(60));
  final seconds = atLeastTwoDigit(remainingTime.inSeconds.remainder(60));
  final remainingTimeString = '$hours:$minutes:$seconds';

  await notificationsPlugin.show(
    NotificationIds.afterTick,
    AppLocalizations.of(context)!.focus,
    '${AppLocalizations.of(context)!.remains}: $remainingTimeString',
    NotificationDetails(
      android: androidDetails,
      linux: linuxDetails,
    ),
  );
}

Future<void> cancelNotification(int notificationId) async {
  await notificationsPlugin.cancel(notificationId);
}

Future<void> cancelAllNotifications() async {
  await cancelNotification(NotificationIds.afterTick);
  await cancelNotification(NotificationIds.shortBreak);
  await cancelNotification(NotificationIds.afterWork);
}
