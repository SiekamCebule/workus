part of 'task_completion_tile.dart';

class _Icon extends ConsumerWidget {
  const _Icon({
    super.key,
    required this.task,
    required this.completed,
  });

  final Task task;
  final bool completed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: Durations.medium2,
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeOutQuint,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: appropiateIcon,
    );
  }

  Widget get appropiateIcon {
    final iconData = completed ? Symbols.task_alt : Symbols.circle_rounded;
    return Icon(
      iconData,
      key: ValueKey(completed),
    );
  }
}
