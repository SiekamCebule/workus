import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/constraints.dart';
import 'package:workus/providers/work_configuration.dart';
import 'package:workus/ui/duration_slider.dart';

class MiniBreakIntervalSlider extends ConsumerWidget {
  const MiniBreakIntervalSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DurationSlider(
      initialMinutes: ref.watch(smallBreakIntervalProvider).inMinutes,
      onChanged: (duration) {
        ref.read(smallBreakIntervalProvider.notifier).state = duration;
      },
      minMinutes: minSmallBreakDuration.inMinutes,
      maxMinutes: maxSmallBreakDuration.inMinutes,
      interval: smallBreakDurationInterval.inMinutes,
    );
  }
}
