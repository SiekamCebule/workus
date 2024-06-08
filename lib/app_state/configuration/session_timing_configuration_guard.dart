import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';

void maybeMatchSessionDurationToShortBreaksInterval(WidgetRef ref) {
  final shortBreaksInterval = ref.read(shortBreaksIntervalProvider);
  final sessionDuration = ref.read(sessionDurationProvider);
  if (shortBreaksInterval == null) return;
  if (shortBreaksInterval > sessionDuration) {
    ref.read(sessionDurationProvider.notifier).state = shortBreaksInterval;
  }
}

void maybeMatchShortBreaksIntervalToSessionDuration(WidgetRef ref) {
  final sessionDuration = ref.read(sessionDurationProvider);
  final shortBreaksInterval = ref.read(shortBreaksIntervalProvider);
  if (shortBreaksInterval == null) return;
  if (shortBreaksInterval > sessionDuration) {
    ref.read(shortBreaksIntervalProvider.notifier).state = sessionDuration;
  }
}
