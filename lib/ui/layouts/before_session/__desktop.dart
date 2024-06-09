part of 'adaptive_before_session_screen.dart';

class _Desktop extends StatelessWidget {
  const _Desktop();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 3,
              child: SessionTimingConfigurator(),
            ),
            Spacer(
              flex: 1,
            ),
            PlayPauseButton(),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        Spacer(),
        SlideoutForPage(
          page: AppPage.work,
          child: TasksToComplete(tasksType: TaskType.beforeSession),
        ),
      ],
    );
  }
}
