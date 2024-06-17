part of 'play_pause_button.dart';

class _PlayButton extends ConsumerStatefulWidget {
  const _PlayButton();

  @override
  ConsumerState<_PlayButton> createState() {
    return _PlayButtonState();
  }
}

class _PlayButtonState extends ConsumerState<_PlayButton> {
  @override
  Widget build(BuildContext context) {
    return _GenericButton(
      icon: const Icon(
        Symbols.play_arrow_rounded,
        weight: 150,
        size: 165,
        fill: 0,
      ),
      onPressed: () {
        if (_sessionIsPaused) {
          _resume();
        } else if (_sessionIsNotStarted) {
          _setUpRandomQuote();
          if (_shouldShowIncompletedTasksDialog) {
            _showDialogAboutIncompleteTasksBeforeSession(context);
          } else {
            _startFromBeginning();
          }
        }
      },
    );
  }

  bool get _sessionIsPaused {
    return ref.read(sessionStatusControllerProvider).status ==
        WorkSessionStatus.pausedByUser;
  }

  bool get _sessionIsNotStarted {
    return ref.read(sessionStatusControllerProvider).status ==
        WorkSessionStatus.notStarted;
  }

  bool get _shouldShowIncompletedTasksDialog {
    return ref.read(shouldShowIncompletedTasksWarningsProvider) && _incompletedTaskExists;
  }

  bool get _incompletedTaskExists {
    final taskStatusesProvider = obtainTaskStatusesProviderByType(TaskType.beforeSession);
    return ref.read(taskStatusesProvider.notifier).incompletedTaskExists;
  }

  void _setUpRandomQuote() {
    ref.read(currentQuoteProvider.notifier).state =
        ref.read(quotesProvider.notifier).randomQuote();
  }

  void _showDialogAboutIncompleteTasksBeforeSession(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return IncompletedTasksBeforeSessionDialog(
          onStartSessionTap: () => _startFromBeginning(),
        );
      },
    );
  }

  void _startFromBeginning() {
    _resetTasksBeforeWork();
    // TODO: Change it
    // ref.watch(userSessionControllerProvider).start(
    //       timingConfiguration: SessionTimingConfiguration(
    //         sessionDuration: ref.watch(sessionDurationProvider),
    //         shortBreaksInterval: ref.watch(shortBreaksIntervalProvider),
    //       ),
    //     );
    ref.watch(userSessionControllerProvider).start(
          timingConfiguration: const SessionTimingConfiguration(
            sessionDuration: Duration(seconds: 10),
            shortBreaksInterval: Duration(seconds: 7),
          ),
        );
  }

  void _resume() => ref.watch(userSessionControllerProvider).resume();

  void _resetTasksBeforeWork() {
    ref.watch(taskBeforeWorkStatusesProvider.notifier).fillEvery(completed: false);
  }
}
