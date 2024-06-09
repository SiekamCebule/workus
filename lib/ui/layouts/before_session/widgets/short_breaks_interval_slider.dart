import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/session_timing_configuration_guard.dart';
import 'package:workus/app_state/constants/constraints.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/initialize.dart';
import 'package:workus/ui/duration_slider.dart';
import 'package:workus/ui/layouts/before_session/widgets/session_duration_slider.dart';

final shortBreaksIntervalBuildNumber = StateProvider<int>((ref) => 0);

class ShortBreaksIntervalSlider extends ConsumerWidget {
  const ShortBreaksIntervalSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appIsInitialized = ref.watch(appIsInitializedProvider);
    final buildNumber = ref.watch(shortBreaksIntervalBuildNumber);
    final keyString = '$appIsInitialized, $buildNumber';
    return DurationSlider(
      key: ValueKey(keyString),
      initialMinutes: ref.read(shortBreaksIntervalProvider)?.inMinutes ?? 0,
      onChanged: (duration) {
        if (duration == Duration.zero) {
          ref.read(shortBreaksIntervalProvider.notifier).state = null;
        } else {
          ref.read(shortBreaksIntervalProvider.notifier).state = duration;
        }
      },
      onSlideEnd: (duration) {
        if (duration > Duration.zero) {
          maybeMatchSessionDurationToShortBreaksInterval(ref);
          ref.read(sessionDurationSliderBuildNumber.notifier).state += 1;
        }
      },
      minMinutes: minShortBreakDuration.inMinutes,
      maxMinutes: maxShortBreakDuration.inMinutes,
      interval: shortBreakDurationInterval.inMinutes,
    );
  }
}
