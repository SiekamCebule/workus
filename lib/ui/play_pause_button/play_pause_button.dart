import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/providers/task_statuse_notifier/task_statuses_notifier.dart';
import 'package:workus/providers/work_configuration.dart';
import 'package:workus/ui/pages/work/dialogs/incompleted_tasks_before_session_dialog.dart';
import 'package:workus/work_flow/work_flow_controller.dart';
import 'package:workus/session_flow/work_flow_messenger.dart';

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
    final workStatus = WorkFlowController.instance.status;

    if (shouldThrowException(workStatus)) {
      throw Exception(
        'The PlayPauseButton should not be tried to built when the workStatus is $workStatus',
      );
    }

    return StreamBuilder(
      stream: WorkFlowMessenger.instance.workSessionStatusStream,
      builder: (context, snapshot) {
        final status = snapshot.data!;
        return AnimatedSwitcher(
          duration: Durations.medium1,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child:
              shouldShowPlayButton(status) ? const _PlayButton() : const _PauseButton(),
        );
      },
    );
  }

  bool shouldShowPlayButton(WorkSessionStatus status) {
    return status == WorkSessionStatus.nonStarted ||
        status == WorkSessionStatus.pausedByUser;
  }

  bool shouldThrowException(WorkSessionStatus? status) {
    return status == WorkSessionStatus.shortBreak ||
        status == WorkSessionStatus.ended ||
        status == WorkSessionStatus.cancelled;
  }
}
