import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/work_configuration.dart';
import 'package:workus/utils/labels.dart';

part '__for_zero_duration.dart';
part '__for_non_zero_duration.dart';

class MiniBreakIntervalTitle extends ConsumerWidget {
  const MiniBreakIntervalTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miniBreakInterval = ref.watch(smallBreakIntervalProvider);

    return miniBreakInterval == Duration.zero
        ? const _ForZeroDuration()
        : _ForNonZeroDuration(duration: miniBreakInterval);
  }
}
