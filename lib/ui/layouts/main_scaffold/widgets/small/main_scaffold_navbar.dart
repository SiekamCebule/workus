import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/constants/navigation.dart';
import 'package:workus/app_state/page_controller.dart';
import 'package:workus/app_state/selected_page.dart';

class MainScaffoldNavbar extends ConsumerWidget {
  const MainScaffoldNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenIndex = ref.watch(selectedPageProvider).index;
    return NavigationBar(
      selectedIndex: screenIndex,
      onDestinationSelected: (index) {
        ref.read(selectedPageProvider.notifier).state = AppPage.fromIndex(index);
        ref.watch(pageControllerProvider.notifier).animateToPage(index);
      },
      destinations: navbarDestinations,
    );
  }
}
