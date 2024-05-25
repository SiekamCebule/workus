import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/settings/settings_page.dart';
import 'package:workus/ui/pages/tasks/tasks_page.dart';
import 'package:workus/ui/pages/work/work_page.dart';

class MainNavigator extends ConsumerWidget {
  const MainNavigator({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/work',
      onGenerateRoute: (settings) {
        final name = settings.name;
        if (name == '/') return null;
        print('generating the $name');
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return switch (name) {
              '/tasks' => const TasksPage(),
              '/work' => const WorkPage(),
              '/settings' => const SettingsPage(),
              _ => throw Exception('An invalid route name'),
            };
          },
        );
      },
    );
  }
}
