part of 'play_pause_button.dart';

class _PlayButton extends ConsumerWidget {
  const _PlayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _GenericButton(
      icon: const Icon(
        Symbols.play_arrow,
        weight: 200,
        size: 180,
      ),
      onPressed: () {
        ref.read(workStatusProvider.notifier).state = WorkStatus.running;
      },
    );
  }
}
