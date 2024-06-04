import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';

final sessionDurationProvider = StateProvider<Duration>(
  (ref) => ref.watch(defaultSessionDurationProvider),
);

final shortBreaksIntervalProvider = StateProvider<Duration?>(
  (ref) => ref.watch(defaultShortBreaksIntervalProvider),
);

final sessionTimingConfigurationProvider = Provider((ref) {
  return SessionTimingConfiguration(
    totalDuration: ref.watch(sessionDurationProvider),
    shortBreaksInterval: ref.watch(shortBreaksIntervalProvider),
  );
});

final smallBreaksEnabledProvider = Provider((ref) {
  return ref.watch(shortBreaksIntervalProvider) != null;
});
