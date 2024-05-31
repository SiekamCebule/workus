part of 'play_pause_button.dart';

class _PlayButton extends ConsumerWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _GenericButton(
      icon: const Icon(
        Symbols.play_arrow_rounded,
        weight: 110,
        size: 205,
        fill: 0,
      ),
      onPressed: () {
        if (_shouldShowDialogAboutIncompleteTasksBeforeSession(ref)) {
          _showDialogAboutIncompleteTasksBeforeSession(context, ref);
        } else {
          _startSessionAppropiately(ref);
        }
      },
    );
  }

  bool _shouldShowDialogAboutIncompleteTasksBeforeSession(WidgetRef ref) {
    final provider = obtainTaskStatusesProviderByType(TaskType.beforeSession);
    bool incompleteTaskExists = ref.read(provider.notifier).incompletedTaskExists;
    return WorkFlowController.instance.status == WorkSessionStatus.nonStarted &&
        incompleteTaskExists;
  }

  void _showDialogAboutIncompleteTasksBeforeSession(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return IncompletedTasksBeforeSessionDialog(
          onStartSessionTap: () => _startFromBeginning(ref),
        );
      },
    );
  }

  void _startFromBeginning(WidgetRef ref) {
    final duration = ref.watch(sessionDurationProvider);
    final shortBreakInterval = ref.watch(shortBreakIntervalProvider);
    WorkFlowController.instance
        .startSession(sessionDuration: duration, shortBreakInterval: shortBreakInterval);
  }

  void _resume() => WorkFlowController.instance.resumeSession();

  void _startSessionAppropiately(WidgetRef ref) {
    switch (WorkFlowController.instance.status) {
      case WorkSessionStatus.pausedByUser:
        _resume();
      case WorkSessionStatus.nonStarted:
        _startFromBeginning(ref);
      default:
        break;
    }
  }
}
