part of 'adaptive_before_session_screen.dart';

class _VerticalTablet extends StatelessWidget {
  const _VerticalTablet();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(),
        LargePlayPauseButton(),
        Spacer(),
        SessionTimingConfigurator(),
        Spacer(),
        SlideoutForPage(
          page: AppPage.work,
          child: TasksToComplete(tasksType: TaskType.beforeSession),
        ),
      ],
    );
  }
}
