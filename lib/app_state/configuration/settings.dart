import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/constants/app_language.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/app_state/constants/predefined_alarm_sounds.dart';

final languageProvider = StateProvider<AppLanguage>(
  (ref) => AppLanguage.english,
);

final shouldShowQuotesProvider = StateProvider<bool>(
  (ref) => true,
);

final shouldShowIncompletedTasksWarningsProvider = StateProvider<bool>(
  (ref) => true,
);

final enableNavigationRailExtendEffectProvider = StateProvider<bool>(
  (ref) => false,
);

final shouldExtendNavigationRailProvider = StateProvider<bool>(
  (ref) => false,
);

final shouldShowNotificationsProvider = StateProvider<bool>(
  (ref) => false,
);

final enableAlarmsProvider = StateProvider<bool>(
  (ref) => false,
);

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

final sessionEndAlarmSoundProvider = StateProvider<AlarmSound?>((ref) {
  return null;
});

final shortBreakAlarmSoundProvider = StateProvider<AlarmSound?>((ref) {
  return null;
});
