import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/session_flow/controlling.dart';
import 'package:workus/ui/dialogs/incompleted_tasks_during_short_break_dialog.dart';

class EndShortBreakButton extends ConsumerStatefulWidget {
  const EndShortBreakButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EndShortBreakButtonState();
  }
}

class _EndShortBreakButtonState extends ConsumerState<EndShortBreakButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (_shouldShowIncompletedTasksDialog) {
          _showIncompletedTasksDialog(context);
        } else {
          endShortBreak(ref);
        }
      },
      child: const Text('Jestem gotów'),
    );
  }

  bool get _shouldShowIncompletedTasksDialog {
    return ref.read(shouldShowIncompletedTasksWarningsProvider) &&
        ref.watch(taskDuringShortBreakStatusesProvider.notifier).incompletedTaskExists;
  }

  Future<void> _showIncompletedTasksDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return IncompletedTasksDuringShortBreakDialog(onEndShortBreakTap: () {
          endShortBreak(ref);
        });
      },
    );
  }
}
