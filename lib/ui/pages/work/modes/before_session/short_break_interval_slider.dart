import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/constants/constraints.dart';
import 'package:workus/providers/configuration/work_configuration.dart';
import 'package:workus/ui/duration_slider.dart';

class ShortBreakIntervalSlider extends ConsumerWidget {
  const ShortBreakIntervalSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DurationSlider(
      initialMinutes: ref.watch(shortBreakIntervalProvider)?.inMinutes ?? 0,
      onChanged: (duration) {
        if (duration == Duration.zero) {
          ref.read(shortBreakIntervalProvider.notifier).state = null;
        } else {
          ref.read(shortBreakIntervalProvider.notifier).state = duration;
        }
      },
      minMinutes: minShortBreakDuration.inMinutes,
      maxMinutes: maxShortBreakDuration.inMinutes,
      interval: shortBreakDurationInterval.inMinutes,
    );
  }
}
