import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/providers/constants/constraints.dart';
import 'package:workus/providers/constants/predefined_alarm_sounds.dart';

final shouldShowQuotesProvider = StateProvider<bool>(
  (ref) => true,
);

final shouldShowIncompletedTasksWarnings = StateProvider<bool>(
  (ref) => true,
);

final defaultSessionDurationProvider = StateProvider<Duration>(
  (ref) {
    _runDefaultSessionDurationGuard(ref);
    return const Duration(hours: 2);
  },
);

void _runDefaultSessionDurationGuard(StateProviderRef ref) {
  final shortBreaksInterval = ref.watch(defaultShortBreaksIntervalProvider);
  final sessionDuration = ref.read(defaultSessionDurationProvider);
  print('$shortBreaksInterval, $sessionDuration');

  if (shortBreaksInterval > sessionDuration) {
    for (var potential in defaultSessionDurationChoices) {
      if (potential > shortBreaksInterval) {
        ref.read(defaultSessionDurationProvider.notifier).state = potential;
        return;
      }
    }
  }
  print('end');
}

final defaultShortBreaksIntervalProvider = StateProvider<Duration>((ref) {
  //_runDefaultShortBreaksIntervalGuard(ref);
  return const Duration(minutes: 40);
});

void _runDefaultShortBreaksIntervalGuard(StateProviderRef ref) {
  final sessionDuration = ref.watch(defaultSessionDurationProvider);
  final shortBreaksInterval = ref.read(defaultShortBreaksIntervalProvider);

  if (sessionDuration < shortBreaksInterval) {
    for (var potential in defaultShortBreaksIntervalChoices.reversed) {
      if (potential < sessionDuration) {
        ref.read(defaultShortBreaksIntervalProvider.notifier).state = potential;
        return;
      }
    }
  }
}

final shortBreakRemindDelayProvider = Provider<Duration>(
  (ref) => const Duration(minutes: 5),
);

final sessionEndAlarmSoundProvider = StateProvider<AlarmSound>((ref) {
  return ref.watch(predefinedAlarmSoundsProvider).first;
});

final shortBreakAlarmSoundProvider = StateProvider<AlarmSound>((ref) {
  return ref.watch(predefinedAlarmSoundsProvider).last;
});
