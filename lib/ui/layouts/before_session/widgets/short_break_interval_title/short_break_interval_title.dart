import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/utils/labels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part '__for_zero_duration.dart';
part '__for_non_zero_duration.dart';

class ShortBreaksIntervalTitle extends ConsumerWidget {
  const ShortBreaksIntervalTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miniBreakInterval = ref.watch(shortBreaksIntervalProvider);

    return miniBreakInterval == null
        ? const _ForZeroDuration()
        : _ForNonZeroDuration(duration: miniBreakInterval);
  }
}
