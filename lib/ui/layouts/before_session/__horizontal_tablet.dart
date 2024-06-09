part of 'adaptive_before_session_screen.dart';

class _HorizontalTablet extends StatelessWidget {
  const _HorizontalTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            SessionTimingConfigurator(),
            Spacer(),
            PlayPauseButton(),
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
