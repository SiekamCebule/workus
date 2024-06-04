import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/providers/global_session_state/session_controlling_module.dart';
import 'package:workus/providers/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/ui/pages/work/dialogs/incompleted_tasks_after_work_dialog.dart';

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
    return ref.read(shouldShowIncompletedTasksWarnings) &&
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
    ref.watch(userSessionControllerProvider).end();
  }
}