import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/app_state/constants/predefined_alarm_sounds.dart';

final shouldShowQuotesProvider = StateProvider<bool>(
  (ref) => true,
);

final shouldShowIncompletedTasksWarningsProvider = StateProvider<bool>(
  (ref) => true,
);

final enableNavigationRailExtendEffectProvider = StateProvider<bool>((ref) => false);
final extendNavigationRailProvider = StateProvider<bool>((ref) => false);

final defaultSessionDurationProvider = StateProvider<Duration>(
  (ref) {
    return const Duration(hours: 2);
  },
);

final defaultShortBreaksIntervalProvider = StateProvider<Duration>((ref) {
  return const Duration(minutes: 40);
});

final shortBreakRemindDelayProvider = Provider<Duration>(
  (ref) => const Duration(minutes: 5),
);

final sessionEndAlarmSoundProvider = StateProvider<AlarmSound>((ref) {
  return ref.watch(predefinedAlarmSoundsProvider).first;
});

final shortBreakAlarmSoundProvider = StateProvider<AlarmSound>((ref) {
  return ref.watch(predefinedAlarmSoundsProvider).last;
});
