import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/work_timer/remaining_session_time_notifier.dart';

class RemainingTimeLabel extends ConsumerWidget {
  const RemainingTimeLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(remainingSessionTimeProvider);
    print(remainingTime);
    return Text(
      timerLabelForDuration(remainingTime),
    );
  }
}

String timerLabelForDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds;
  var label = '';

  if (hours > 0) {
    label += '${atLeastTwoDigit(hours)}g ';
  } else if (minutes > 0) {
    label += '${atLeastTwoDigit(minutes)}m ';
  } else if (seconds > 0) {
    label += '${atLeastTwoDigit(seconds)}s ';
  }
  return label.trim();
}

String atLeastTwoDigit(int number) {
  if (number < 10) {
    return '0$number';
  } else {
    return number.toString();
  }
}
