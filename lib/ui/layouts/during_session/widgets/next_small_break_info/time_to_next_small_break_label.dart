import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/utils/labels.dart';

class TimeToNextSmallBreakLabel extends ConsumerWidget {
  const TimeToNextSmallBreakLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timesToSmallBreak =
        ref.watch(sessionStatsBroadcasterProvider).timesToShortBreak;

    return StreamBuilder(
      initialData: timesToSmallBreak.value,
      stream: timesToSmallBreak,
      builder: (context, snapshot) {
        final timeToSmallBreak = snapshot.data!;
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Przerwa za ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              TextSpan(
                text: labelForDuration(timeToSmallBreak),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
