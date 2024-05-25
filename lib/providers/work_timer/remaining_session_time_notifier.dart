import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/work_timer/timer_remaining_time_notifier.dart';

final remainingSessionTimeProvider = NotifierProvider<TimerRemainingTimeNotifier, Duration>(
  () => TimerRemainingTimeNotifier(
    interval: const Duration(seconds: 1),
  ),
);
