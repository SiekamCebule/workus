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
      initialMinutes: ref.watch(shortBreakIntervalProvider).inMinutes,
      onChanged: (duration) {
        ref.read(shortBreakIntervalProvider.notifier).state = duration;
      },
      minMinutes: minShortBreakDuration.inMinutes,
      maxMinutes: maxShortBreakDuration.inMinutes,
      interval: shortBreakDurationInterval.inMinutes,
    );
  }
}
