import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/providers/page_controller.dart';
import 'package:workus/providers/selected_page.dart';

class MainScaffoldNavbar extends ConsumerWidget {
  const MainScaffoldNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenIndex = ref.watch(selectedPageProvider).index;
    return NavigationBar(
      selectedIndex: screenIndex,
      onDestinationSelected: (index) {
        ref.read(selectedPageProvider.notifier).state =
            AppPage.fromIndex(index);
        ref.watch(pageControllerProvider.notifier).animateToPage(index);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Symbols.checklist),
          label: 'Zadania',
        ),
        NavigationDestination(
          icon: Icon(Symbols.timelapse),
          label: 'Praca',
        ),
        NavigationDestination(
          icon: Icon(Symbols.settings),
          label: 'Ustawienia',
        ),
      ],
    );
  }
}
