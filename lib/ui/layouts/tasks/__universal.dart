part of 'adaptive_tasks_screen.dart';

class _Universal extends StatelessWidget {
  const _Universal();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 1),
        TaskTypesSegmentedButton(),
        Gap(15),
        Expanded(
          flex: 4,
          child: TasksView(),
        ),
      ],
    );
  }
}
