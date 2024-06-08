import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/session_timing_configuration_guard.dart';
import 'package:workus/app_state/constants/constraints.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/initialize.dart';
import 'package:workus/ui/duration_slider.dart';
import 'package:workus/ui/pages/work/modes/before_session/short_breaks_interval_slider.dart';

final sessionDurationSliderBuildNumber = StateProvider<int>((ref) => 0);

class SessionDurationSlider extends ConsumerWidget {
  const SessionDurationSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appIsInitialized = ref.watch(appIsInitializedProvider);
    final buildNumber = ref.watch(sessionDurationSliderBuildNumber);
    final keyString = '$appIsInitialized, $buildNumber';
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return DurationSlider(
            key: ValueKey(keyString),
            initialMinutes: ref.read(sessionDurationProvider).inMinutes,
            onChanged: (duration) {
              ref.read(sessionDurationProvider.notifier).state = duration;
            },
            onSlideEnd: (duration) {
              maybeMatchShortBreaksIntervalToSessionDuration(ref);
              ref.read(shortBreaksIntervalBuildNumber.notifier).state += 1;
            },
            minMinutes: minSessionDuration.inMinutes,
            maxMinutes: maxSessionDuration.inMinutes,
            interval: sessionDurationInterval.inMinutes,
          );
        });
  }
}
