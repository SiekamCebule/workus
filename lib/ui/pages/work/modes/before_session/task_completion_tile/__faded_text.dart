part of 'task_completion_tile.dart';

class _FadedText extends StatelessWidget {
  const _FadedText({
    super.key,
    required this.text,
    required this.faded,
  });

  final String text;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: faded ? 0.55 : 1.0,
      duration: Durations.medium3,
      curve: Curves.decelerate,
      child: Text(text),
    );
  }
}
