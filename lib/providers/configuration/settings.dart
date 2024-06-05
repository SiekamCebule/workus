import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/providers/constants/predefined_alarm_sounds.dart';

final shouldShowQuotesProvider = StateProvider<bool>(
  (ref) => true,
);

final shouldShowIncompletedTasksWarnings = StateProvider<bool>(
  (ref) => true,
);

final defaultSessionDurationProvider = StateProvider<Duration>(
  (ref) => const Duration(hours: 1),
);

final defaultShortBreaksIntervalProvider = StateProvider<Duration>(
  (ref) => const Duration(minutes: 30),
);

final shortBreakRemindDelayProvider = Provider<Duration>(
  (ref) => const Duration(seconds: 12),
);

final sessionEndAlarmSoundProvider = StateProvider<AlarmSound>((ref) {
  return ref.watch(predefinedAlarmSoundsProvider).first;
});

final shortBreakAlarmSoundProvider = StateProvider<AlarmSound>((ref) {
  return ref.watch(predefinedAlarmSoundsProvider).last;
});
