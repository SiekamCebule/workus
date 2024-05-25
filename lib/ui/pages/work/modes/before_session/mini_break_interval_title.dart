import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/work_configuration.dart';
import 'package:workus/utils/labels.dart';

class MiniBreakIntervalTitle extends ConsumerWidget {
  const MiniBreakIntervalTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miniBreakInterval = ref.watch(miniBreakIntervalProvider);
    final labelForMiniBreakInterval = labelForDuration(miniBreakInterval);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Mini przerwa co ',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: labelForMiniBreakInterval,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
