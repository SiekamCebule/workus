part of 'adaptive_before_session_screen.dart';

class _Vertical extends StatelessWidget {
  const _Vertical();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutType = LayoutType.fromConstraints(constraints);
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            shouldShowLargePlayPauseButton(layoutType)
                ? const LargePlayPauseButton()
                : const PlayPauseButton(),
            const Spacer(),
            const SessionTimingConfigurator(),
            const Spacer(),
            const SlideoutForPage(
              page: AppPage.work,
              child: TasksToComplete(tasksType: TaskType.beforeSession),
            ),
          ],
        );
      },
    );
  }
}
