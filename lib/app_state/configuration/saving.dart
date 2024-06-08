import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workus/app_state/configuration/settings.dart';

Future<void> saveSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  _saveShowQuotes(ref, prefs);
  _saveShowIncompletedTasksWarnings(ref, prefs);
  _saveDefaultSessionDuration(ref, prefs);
  _saveDefaultShortBreakInterval(ref, prefs);
  _saveShortBreakRemindDelay(ref, prefs);
  _saveSessionEndAlarmSound(ref, prefs);
  _saveShortBreakAlarmSound(ref, prefs);
}

void _saveShortBreakAlarmSound(WidgetRef ref, SharedPreferences prefs) {
  final shortBreakAlarm = ref.read(shortBreakAlarmSoundProvider);
  prefs.setString('short_break_alarm_sound', shortBreakAlarm.id);
}

void _saveSessionEndAlarmSound(WidgetRef ref, SharedPreferences prefs) {
  final sessionEndAlarm = ref.read(sessionEndAlarmSoundProvider);
  prefs.setString('session_end_alarm_sound', sessionEndAlarm.id);
}

void _saveShortBreakRemindDelay(WidgetRef ref, SharedPreferences prefs) {
  final shortBreakRemindDelay = ref.read(defaultShortBreaksIntervalProvider);
  prefs.setInt('short_break_remind_delay_in_minutes', shortBreakRemindDelay.inMinutes);
}

void _saveDefaultShortBreakInterval(WidgetRef ref, SharedPreferences prefs) {
  final defaultShortBreakInterval = ref.read(defaultShortBreaksIntervalProvider);
  prefs.setInt(
      'default_short_breaks_interval_in_minutes', defaultShortBreakInterval.inMinutes);
}

void _saveDefaultSessionDuration(WidgetRef ref, SharedPreferences prefs) {
  final defaultSessionDuration = ref.read(defaultSessionDurationProvider);
  prefs.setInt('default_session_duration_in_minutes', defaultSessionDuration.inMinutes);
}

void _saveShowIncompletedTasksWarnings(WidgetRef ref, SharedPreferences prefs) {
  final showIncompletedTasksWarnings =
      ref.read(shouldShowIncompletedTasksWarningsProvider);
  prefs.setBool('show_incompleted_tasks_warnings', showIncompletedTasksWarnings);
}

void _saveShowQuotes(WidgetRef ref, SharedPreferences prefs) {
  final showQuotes = ref.read(shouldShowQuotesProvider);
  prefs.setBool('show_quotes', showQuotes);
}
