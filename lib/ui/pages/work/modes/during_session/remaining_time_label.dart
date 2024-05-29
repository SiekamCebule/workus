import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/work_flow/work_flow_controller.dart';

import 'package:workus/work_flow/work_flow_controller_messenger.dart';

class RemainingTimeLabel extends ConsumerWidget {
  const RemainingTimeLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: WorkFlowControllerMessenger.instance.remainingSessionTimeStream,
      builder: (context, snapshot) {
        final remainingTime = snapshot.data ?? WorkFlowController.instance.remainingSessionTime;
        return Text(
          timerLabelForDuration(remainingTime),
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}

String timerLabelForDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;
  var label = '';

  if (hours > 0) {
    label += '${atLeastTwoDigit(hours)}g ';
  }
  if (minutes > 0) {
    label += '${atLeastTwoDigit(minutes)}m ';
  }
  if (seconds > 0) {
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
