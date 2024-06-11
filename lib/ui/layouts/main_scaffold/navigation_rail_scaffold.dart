import 'package:flutter/material.dart';
import 'package:workus/ui/layouts/main_scaffold/widgets/large/large_main_scaffold_content.dart';
import 'package:workus/ui/layouts/main_scaffold/widgets/large/main_scaffold_navigation_rail.dart';

class NavigationRailScaffold extends StatelessWidget {
  const NavigationRailScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          MainScaffoldNavigationRail(),
          Expanded(child: LargeMainScaffoldContent()),
        ],
      ),
    );
  }
}
