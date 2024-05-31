import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/utils/labels.dart';

import 'package:workus/work_flow/work_flow_messenger.dart';

class RemainingTimeLabel extends ConsumerWidget {
  const RemainingTimeLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: WorkFlowMessenger.instance.remainingSessionTimeStream,
      builder: (context, snapshot) {
        final remainingTime = snapshot.data!;
        return Text(
          labelForDuration(remainingTime),
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
