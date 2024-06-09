import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/settings/adaptive_settings_screen.dart';
import 'package:workus/ui/layouts/tasks/adaptive_tasks_screen.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/dynamic_work_screen.dart';

class LargeMainScaffoldContent extends ConsumerWidget {
  const LargeMainScaffoldContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageProvider);
    final pageWidget = switch (selectedPage) {
      AppPage.tasks => const AdaptiveTasksScreen(),
      AppPage.work => const DynamicWorkScreen(),
      AppPage.settings => const AdaptiveSettingsScreen(),
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
