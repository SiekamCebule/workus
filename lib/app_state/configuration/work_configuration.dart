import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';

final sessionDurationProvider = StateProvider<Duration>(
  (ref) => ref.watch(defaultSessionDurationProvider),
);

final shortBreaksIntervalProvider = StateProvider<Duration?>(
  (ref) => ref.watch(defaultShortBreaksIntervalProvider),
);

final sessionTimingConfigurationProvider = Provider((ref) {
  return SessionTimingConfiguration(
    sessionDuration: ref.watch(sessionDurationProvider),
    shortBreaksInterval: ref.watch(shortBreaksIntervalProvider),
  );
});

final smallBreaksAreEnabledProvider = StateProvider((ref) {
  final shortBreaksInterval = ref.watch(shortBreaksIntervalProvider);
  final sessionDuration = ref.watch(sessionDurationProvider);
  if (sessionDuration == shortBreaksInterval) {
    return false;
  }
  return shortBreaksInterval != null;
});
