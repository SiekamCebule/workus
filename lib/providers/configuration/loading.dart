import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/providers/constants/predefined_alarm_sounds.dart';

Future<void> loadSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  _loadShowQuotes(ref, prefs);
  _loadShowIncompletedTasksWarnings(ref, prefs);
  _loadDefaultSessionDuration(ref, prefs);
  _loadDefaultShortBreakInterval(ref, prefs);
  _loadShortBreakRemindDelay(ref, prefs);
  _loadSessionEndAlarmSound(prefs, ref);
  _loadShortBreakAlarmSound(prefs, ref);
}

void _loadShortBreakAlarmSound(SharedPreferences prefs, WidgetRef ref) {
  final shortBreakAlarmId = prefs.getString('short_break_alarm_sound') ?? 'irish_folk';

  ref.read(shortBreakAlarmSoundProvider.notifier).state =
      ref.read(predefinedAlarmSoundsProvider).singleWhere(
            (sound) => sound.id == shortBreakAlarmId,
          );
}

void _loadSessionEndAlarmSound(SharedPreferences prefs, WidgetRef ref) {
  final sessionEndAlarmId =
      prefs.getString('session_end_alarm_sound') ?? 'spanish_guitar';

  ref.read(sessionEndAlarmSoundProvider.notifier).state =
      ref.read(predefinedAlarmSoundsProvider).singleWhere(
            (sound) => sound.id == sessionEndAlarmId,
          );
}

void _loadShortBreakRemindDelay(WidgetRef ref, SharedPreferences prefs) {
  ref.read(defaultShortBreaksIntervalProvider.notifier).state = Duration(
    minutes: prefs.getInt('short_break_remind_delay_in_minutes') ?? 5,
  );
}

void _loadDefaultShortBreakInterval(WidgetRef ref, SharedPreferences prefs) {
  ref.read(defaultShortBreaksIntervalProvider.notifier).state = Duration(
    minutes: prefs.getInt('default_short_breaks_interval_in_minutes') ?? 40,
  );
}

void _loadDefaultSessionDuration(WidgetRef ref, SharedPreferences prefs) {
  ref.read(defaultSessionDurationProvider.notifier).state = Duration(
    minutes: prefs.getInt('default_session_duration_in_minutes') ?? 120,
  );
}

void _loadShowIncompletedTasksWarnings(WidgetRef ref, SharedPreferences prefs) {
  ref.read(shouldShowIncompletedTasksWarnings.notifier).state =
      prefs.getBool('show_incompleted_tasks_warnings') ?? true;
}

void _loadShowQuotes(WidgetRef ref, SharedPreferences prefs) {
  ref.read(shouldShowQuotesProvider.notifier).state =
      prefs.getBool('show_quotes') ?? true;
}
