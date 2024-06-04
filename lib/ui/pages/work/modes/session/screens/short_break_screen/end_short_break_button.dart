import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/providers/global_session_state/session_controlling_module.dart';
import 'package:workus/providers/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:workus/ui/pages/work/dialogs/incompleted_tasks_during_short_break_dialog.dart';

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
          _endShortBreak();
        }
      },
      child: const Text('Jestem gotów'),
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
        return IncompletedTasksDuringShortBreakDialog(onEndShortBreakTap: () {
          _endShortBreak();
        });
      },
    );
  }

  void _endShortBreak() {
    ref.watch(userSessionControllerProvider).end();
    ref
        .watch(taskDuringShortBreakStatusesProvider.notifier)
        .fillCurrent(completed: false);
  }
}
