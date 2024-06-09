part of 'adaptive_before_session_screen.dart';

class _VerticalPhone extends StatelessWidget {
  const _VerticalPhone();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(),
        PlayPauseButton(),
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
