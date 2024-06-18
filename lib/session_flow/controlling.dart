import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/notifications/sending_notifications.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';

Future<void> endShortBreak(WidgetRef ref) async {
  if (ref.read(enableAlarmsProvider)) {
    ref.read(alarmPlayerProvider).stop();
  }
  ref.read(userSessionControllerProvider).endShortBreak();
  ref.read(taskDuringShortBreakStatusesProvider.notifier).fillEvery(completed: false);
  await cancelAllNotifications();
}

Future<void> endSession(WidgetRef ref) async {
  if (ref.read(enableAlarmsProvider)) {
    ref.read(alarmPlayerProvider).stop();
  }
  ref.read(userSessionControllerProvider).end();
  await cancelAllNotifications();
}

Future<void> cancelSession(WidgetRef ref) async {
  if (ref.read(enableAlarmsProvider)) {
    ref.read(alarmPlayerProvider).stop();
  }
  ref.read(userSessionControllerProvider).cancel();
  await cancelAllNotifications();
}
