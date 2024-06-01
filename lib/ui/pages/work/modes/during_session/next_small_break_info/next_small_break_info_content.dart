import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/ui/pages/work/modes/during_session/next_small_break_info/small_break_timer_icon.dart';
import 'package:workus/ui/pages/work/modes/during_session/next_small_break_info/time_to_next_small_break_label.dart';

class NextSmallBreakInfoContent extends ConsumerWidget {
  const NextSmallBreakInfoContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: const Row(
        children: [
          Gap(10),
          SmallBreakTimerIcon(),
          Gap(15),
          TimeToNextSmallBreakLabel(),
        ],
      ),
    );
  }
}
