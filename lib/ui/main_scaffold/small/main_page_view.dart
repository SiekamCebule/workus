import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/page_controller.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/settings/adaptive_settings_screen.dart';
import 'package:workus/ui/layouts/tasks/adaptive_tasks_screen.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/dynamic_work_screen.dart';

class MainPageView extends ConsumerStatefulWidget {
  const MainPageView({super.key});

  @override
  ConsumerState<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends ConsumerState<MainPageView> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(pageControllerProvider);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      onPageChanged: (index) {
        ref.read(selectedPageProvider.notifier).state = AppPage.fromIndex(index);
      },
      children: const [
        AdaptiveTasksScreen(),
        DynamicWorkScreen(),
        AdaptiveSettingsScreen(),
      ],
    );
  }
}
