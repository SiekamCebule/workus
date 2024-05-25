import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/work_configuration.dart';
import 'package:workus/ui/duration_slider.dart';

class SessionDurationSlider extends ConsumerWidget {
  const SessionDurationSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DurationSlider(
      initialMinutes: ref.watch(sessionDurationProvider).inMinutes,
      onChanged: (duration) {
        ref.read(sessionDurationProvider.notifier).state = duration;
      },
      maxMinutes: 300,
      interval: 20,
    );
  }
}
