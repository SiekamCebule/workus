import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/page_controller.dart';
import 'package:workus/providers/selected_page.dart';
import 'package:workus/ui/pages/settings/settings_page.dart';
import 'package:workus/ui/pages/tasks/tasks_page.dart';
import 'package:workus/ui/pages/work/work_page.dart';

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
        TasksPage(),
        WorkPage(),
        SettingsPage(),
      ],
    );
  }
}
