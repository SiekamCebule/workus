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
        if (incompleteTaskExists(TaskType.beforeSession, ref)) {
          showDialog(
            context: context,
            builder: (context) {
              return IncompletedTasksBeforeSessionDialog(
                onStartSessionTap: () => _startSession(ref),
              );
            },
          );
        } else {
          _startSession(ref);
        }
        print('session started');
      },
    );
  }

  void _startSession(WidgetRef ref) {
    final duration = ref.watch(sessionDurationProvider);
    final smallBreakInterval = ref.watch(smallBreakIntervalProvider);
    WorkFlowController.instance.startSession(duration, smallBreakInterval);
  }
}
