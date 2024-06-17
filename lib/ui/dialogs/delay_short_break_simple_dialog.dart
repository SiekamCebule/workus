import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DelayShortBreakSimpleDialog extends ConsumerStatefulWidget {
  const DelayShortBreakSimpleDialog({super.key});

  @override
  ConsumerState<DelayShortBreakSimpleDialog> createState() =>
      _DelayShortBreakSimpleDialogState();
}

class _DelayShortBreakSimpleDialogState
    extends ConsumerState<DelayShortBreakSimpleDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(AppLocalizations.of(context)!.delayBreakBy),
      children: [
        SimpleDialogOption(
          onPressed: () {
            ref.watch(alarmPlayerProvider).stop();
            _delayShortBreak(const Duration(minutes: 3));
            _closeDialog();
          },
          child: Text('3 ${AppLocalizations.of(context)!.minutes(3)}'),
        ),
        SimpleDialogOption(
          onPressed: () {
            ref.watch(alarmPlayerProvider).stop();
            _delayShortBreak(const Duration(minutes: 5));
            _closeDialog();
          },
          child: Text('5 ${AppLocalizations.of(context)!.minutes(5)}'),
        ),
        SimpleDialogOption(
          onPressed: () {
            ref.watch(alarmPlayerProvider).stop();
            _delayShortBreak(const Duration(minutes: 10));
            _closeDialog();
          },
          child: Text('10 ${AppLocalizations.of(context)!.minutes(10)}'),
        ),
      ],
    );
  }

  void _delayShortBreak(Duration delay) {
    ref.watch(taskDuringShortBreakStatusesProvider.notifier).fillEvery(completed: false);
    ref.watch(alarmPlayerProvider).stop();
    final controller = ref.read(userSessionControllerProvider);
    controller.delayShortBreak(delay: delay);
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }
}

Future<void> showDelayShortBreakSimpleDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const DelayShortBreakSimpleDialog();
    },
  );
}
