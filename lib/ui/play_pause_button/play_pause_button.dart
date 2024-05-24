import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/providers/work_status.dart';

part '__generic_button.dart';
part '__pause_button.dart';
part '__play_button.dart';

class PlayPauseButton extends ConsumerStatefulWidget {
  const PlayPauseButton({super.key});

  @override
  ConsumerState<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends ConsumerState<PlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    final workStatus = ref.watch(workStatusProvider);
    if (shouldThrowException(workStatus)) {
      throw Exception(
        'The PlayPauseButton should not be tried to built when the workStatus is $workStatus',
      );
    }

    return AnimatedSwitcher(
      duration: Durations.short4,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: shouldShowPlayButton(workStatus)
          ? const _PlayButton()
          : const _PauseButton(),
    );
  }

  bool shouldShowPlayButton(WorkStatus? status) {
    return status == null || status == WorkStatus.pausedByUser;
  }

  bool shouldThrowException(WorkStatus? status) {
    return status == WorkStatus.miniBreak || status == WorkStatus.ended;
  }
}
