import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/navigation.dart';
import 'package:workus/app_state/constants/platform.dart';
import 'package:workus/app_state/selected_page.dart';

class MainScaffoldNavigationRail extends ConsumerStatefulWidget {
  const MainScaffoldNavigationRail({super.key});

  @override
  ConsumerState<MainScaffoldNavigationRail> createState() =>
      _MainScaffoldNavigationRailState();
}

class _MainScaffoldNavigationRailState extends ConsumerState<MainScaffoldNavigationRail> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _hovered = false;
        });
      },
      child: NavigationRail(
        extended: _railShouldBeExtended,
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

  bool get _railShouldBeExtended {
    final enableExtendEffect = ref.watch(enableNavigationRailExtendEffectProvider);
    final extendRail = ref.watch(extendNavigationRailProvider);

    if (platformIsDesktop && enableExtendEffect) {
      return _hovered;
    } else if (!platformIsDesktop && extendRail) {
      return true;
    } else {
      return false;
    }
  }
}
