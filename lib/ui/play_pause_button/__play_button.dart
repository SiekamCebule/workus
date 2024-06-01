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
        weight: 110,
        size: 205,
        fill: 0,
      ),
      onPressed: () {
        if (_sessionIsPaused) {
          _resume(ref);
        } else if (_sessionIsNotStarted) {
          _setUpRandomQuote();
          if (_incompletedTaskExists) {
            _showDialogAboutIncompleteTasksBeforeSession(context);
          } else {
            _startFromBeginning(ref);
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
          onStartSessionTap: () => _startFromBeginning(ref),
        );
      },
    );
  }

  void _startFromBeginning(WidgetRef ref) {
    ref
        .watch(userSessionControllerProvider)
        .start(timingConfiguration: ref.watch(sessionTimingConfigurationProvider));
  }

  void _resume(WidgetRef ref) => ref.watch(userSessionControllerProvider).resume();
}
