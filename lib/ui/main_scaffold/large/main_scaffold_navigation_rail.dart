import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/navigation.dart';
import 'package:workus/app_state/selected_page.dart';

class MainScaffoldNavigationRail extends ConsumerStatefulWidget {
  const MainScaffoldNavigationRail({super.key});

  @override
  ConsumerState<MainScaffoldNavigationRail> createState() =>
      _MainScaffoldNavigationRailState();
}

class _MainScaffoldNavigationRailState extends ConsumerState<MainScaffoldNavigationRail> {
  bool _extended = false;

  @override
  Widget build(BuildContext context) {
    final shouldExtendNavigationRail = ref.watch(shouldExtendNavigationRailProvider);
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _extended = true;
        });
      },
      onExit: (event) {
        setState(() {
          _extended = false;
        });
      },
      child: NavigationRail(
        extended: shouldExtendNavigationRail ? _extended : false,
        minExtendedWidth: 160,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        destinations: navigationRailDestinations,
        selectedIndex: ref.watch(selectedPageProvider).index,
        onDestinationSelected: (destinationIndex) {
          ref.watch(selectedPageProvider.notifier).state =
              AppPage.fromIndex(destinationIndex);
        },
      ),
    );
  }
}
