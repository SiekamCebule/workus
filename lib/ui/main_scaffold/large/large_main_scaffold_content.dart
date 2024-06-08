import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/pages/settings/settings_page.dart';
import 'package:workus/ui/pages/tasks/tasks_page.dart';
import 'package:workus/ui/pages/work/work_page.dart';

class LargeMainScaffoldContent extends ConsumerWidget {
  const LargeMainScaffoldContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageProvider);
    final pageWidget = switch (selectedPage) {
      AppPage.tasks => const TasksPage(),
      AppPage.work => const WorkPage(),
      AppPage.settings => const SettingsPage(),
    };
    return AnimatedSwitcher(
      duration: Durations.short2,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.decelerate,
      transitionBuilder: (child, animation) {
        final position = animation.drive(
          Tween(begin: const Offset(1, 0), end: Offset.zero),
        );
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return child!;
          },
          child: SlideTransition(
            position: position,
            child: child,
          ),
        );
      },
      child: pageWidget,
    );
  }
}
