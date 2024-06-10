part of 'adaptive_before_session_screen.dart';

class _HorizontalPhone extends StatelessWidget {
  const _HorizontalPhone();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: IntrinsicHeight(child: SessionTimingConfigurator()),
        ),
        _ScaledPlayPauseButton(),
        Gap(5),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _TasksToCompleteWidget(),
          ),
        ),
      ],
    );
  }
}

class _TasksToCompleteWidget extends StatelessWidget {
  const _TasksToCompleteWidget();

  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
      ),
      child: IntrinsicHeight(
        child: SlideoutForPage(
          page: AppPage.work,
          child: OverflowBox(
            maxHeight: double.infinity,
            child: TasksToComplete(
              topPadding: 20,
              bottomPadding: 20,
              tasksType: TaskType.beforeSession,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScaledPlayPauseButton extends StatelessWidget {
  const _ScaledPlayPauseButton();

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.85,
      child: const PlayPauseButton(),
    );
  }
}
