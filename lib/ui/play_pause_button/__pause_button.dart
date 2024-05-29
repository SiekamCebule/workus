part of 'play_pause_button.dart';

class _PauseButton extends ConsumerWidget {
  const _PauseButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _GenericButton(
      icon: const Icon(
        Symbols.pause_rounded,
        weight: 110,
        size: 150,
        fill: 0,
      ),
      onPressed: () {
        WorkFlowController.instance.pauseSession();
      },
    );
  }
}
