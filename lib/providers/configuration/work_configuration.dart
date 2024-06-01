import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';

// TODO: Some default duration
final sessionDurationProvider = StateProvider<Duration>(
  (ref) => const Duration(minutes: 30),
);

// TODO: Some default interval
final shortBreakIntervalProvider = StateProvider<Duration?>(
  (ref) => const Duration(minutes: 15),
);

final sessionTimingConfigurationProvider = Provider((ref) {
  return SessionTimingConfiguration(
    totalDuration: ref.watch(sessionDurationProvider),
    shortBreakInterval: ref.watch(shortBreakIntervalProvider),
  );
});

final smallBreaksEnabledProvider = Provider((ref) {
  return ref.watch(shortBreakIntervalProvider) != null;
});
