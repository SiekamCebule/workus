import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/providers/global_session_state/session_controlling_module.dart';
import 'package:workus/providers/tasks_management/task_statuses_notifier/task_statuses_notifier.dart';

class ShortBreakRemindButton extends ConsumerWidget {
  const ShortBreakRemindButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delay = ref.watch(shortBreakRemindDelayProvider);
    _validateDelayAndMaybeThrow(delay);

    final delayNumber = _delayNumber(delay);
    final delayWord = _delayWord(delay);

    return OutlinedButton(
      onPressed: () {
        ref.watch(userSessionControllerProvider).remindShortBreak(delay: delay);
        ref
            .watch(taskDuringShortBreakStatusesProvider.notifier)
            .fillCurrent(completed: false);
      },
      child: Text('Przypomnij za $delayNumber $delayWord'),
    );
  }

  void _validateDelayAndMaybeThrow(Duration delay) {
    final minutesDelayWithoutHours = delay.inMinutes % 60;
    final secondsDelay = delay.inSeconds;

    if (minutesDelayWithoutHours > 99 || secondsDelay < 10) {
      _throwInvalidShortBreakRemindDelayError();
    }
  }

  void _throwInvalidShortBreakRemindDelayError() {
    throw StateError(
      'Due to a design decision, the short break remind delay has to be from the range of <10 seconds, 99 minutes>',
    );
  }

  int _delayNumber(Duration delay) {
    if (delay.inMinutes > 0) {
      return delay.inMinutes;
    } else {
      return delay.inSeconds;
    }
  }

  String _delayWord(Duration delay) {
    if (delay.inMinutes > 0) {
      return _minutesWord(delay.inMinutes);
    } else {
      return _secondsWord(delay.inSeconds);
    }
  }

  String _secondsWord(int seconds) {
    if (seconds == 1) {
      return 'sekundę';
    } else if (seconds >= 2 && seconds <= 4) {
      return 'sekundy';
    } else {
      return 'sekund';
    }
  }

  String _minutesWord(int minutes) {
    if (minutes == 1) {
      return 'minutę';
    } else if (minutes >= 2 && minutes <= 4) {
      return 'minuty';
    } else {
      return 'minut';
    }
  }
}
