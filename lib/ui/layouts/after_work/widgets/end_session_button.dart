import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/ui/dialogs/incompleted_tasks_after_work_dialog.dart';

class EndSessionButton extends ConsumerStatefulWidget {
  const EndSessionButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SessionEndButtonState();
  }
}

class _SessionEndButtonState extends ConsumerState<EndSessionButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (_shouldShowIncompletedTasksDialog) {
          _showIncompletedTasksDialog(context);
        } else {
          _endSession();
        }
      },
      child: const Text('Zakończ sesję'),
    );
  }

  bool get _shouldShowIncompletedTasksDialog {
    return ref.read(shouldShowIncompletedTasksWarningsProvider) &&
        ref.watch(taskAfterWorkStatusesProvider.notifier).incompletedTaskExists;
  }

  Future<void> _showIncompletedTasksDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return IncompletedTasksAfterWorkDialog(onEndSessionTap: () {
          _endSession();
        });
      },
    );
  }

  void _endSession() {
    ref.watch(alarmPlayerProvider).stop();
    ref.watch(userSessionControllerProvider).end();
  }
}
