part of 'play_pause_button.dart';

class _PlayButton extends ConsumerWidget {
  const _PlayButton({super.key});

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
        ref.read(workStatusProvider.notifier).state = WorkStatus.running;
        ref.read(remainingSessionTimeProvider.notifier).onEnd = () {
          print('Wow! An end!');
        };
        ref.read(remainingSessionTimeProvider.notifier).intervalCallback = () {
          print('Every second callback...');
        };
        ref.read(remainingSessionTimeProvider.notifier).start(
              const Duration(seconds: 10),
            );
      },
    );
  }
}
