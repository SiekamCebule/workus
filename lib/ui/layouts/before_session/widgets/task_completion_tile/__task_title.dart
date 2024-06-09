part of 'task_completion_tile.dart';

class _TaskTitle extends StatefulWidget {
  const _TaskTitle({
    required this.taskContent,
    required this.taskCompleted,
  });

  final String taskContent;
  final bool taskCompleted;

  @override
  State<_TaskTitle> createState() => _TaskTitleState();
}

class _TaskTitleState extends State<_TaskTitle> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> progress;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
    progress = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    if (widget.taskCompleted) {
      controller.value = 1.0;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _TaskTitle oldWidget) {
    if (oldWidget.taskCompleted != widget.taskCompleted) {
      toggleAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.onTertiaryContainer;
    const lineHeight = 2.0;
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return CustomPaint(
          painter: CrossOutPainter(
            progress: progress.value,
            color: lineColor,
            lineHeight: lineHeight,
          ),
          child: _FadedText(
            text: widget.taskContent,
            faded: widget.taskCompleted,
          ),
        );
      },
    );
  }

  void toggleAnimation() {
    if (shouldGoReverse) {
      controller.reverse();
    } else if (shouldGoForward) {
      controller.forward();
    }
  }

  bool get shouldGoReverse => controller.isForwardOrCompleted;
  bool get shouldGoForward {
    return controller.isDismissed || controller.status == AnimationStatus.reverse;
  }
}
