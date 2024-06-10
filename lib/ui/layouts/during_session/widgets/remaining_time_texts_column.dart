import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/ui/layouts/during_session/widgets/remaining_time_text.dart';

class RemainingTimeTextsColumn extends ConsumerWidget {
  const RemainingTimeTextsColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTimes = ref.watch(sessionStatsBroadcasterProvider).remainingTimes;
    return StreamBuilder(
        initialData: remainingTimes.value,
        stream: remainingTimes,
        builder: (context, snapshot) {
          final remainingTime = snapshot.data!;
          final hours = remainingTime.inHours;
          final minutes = remainingTime.inMinutes.remainder(60);
          final seconds = remainingTime.inSeconds.remainder(60);
          return Column(
            children: [
              if (hours > 0) const RemainingTimeText(type: RemainingTimeType.hours),
              if (minutes > 0) const RemainingTimeText(type: RemainingTimeType.minutes),
              if (seconds > 0) const RemainingTimeText(type: RemainingTimeType.seconds),
            ],
          );
        });
  }
}
