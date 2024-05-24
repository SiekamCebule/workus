part of 'play_pause_button.dart';

class _PauseButton extends ConsumerWidget {
  const _PauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _GenericButton(
      icon: const Icon(
        Symbols.pause,
        weight: 200,
        size: 150,
      ),
      onPressed: () {
        ref.read(workStatusProvider.notifier).state = WorkStatus.pausedByUser;
      },
    );
  }
}
