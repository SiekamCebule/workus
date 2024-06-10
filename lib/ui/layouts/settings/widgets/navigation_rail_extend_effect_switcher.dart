import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';

class NavigationRailExtendEffectSwitcher extends ConsumerWidget {
  const NavigationRailExtendEffectSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extendNavigationRail = ref.watch(enableNavigationRailExtendEffectProvider);

    return SwitchListTile(
      value: extendNavigationRail,
      onChanged: (selected) {
        ref.watch(enableNavigationRailExtendEffectProvider.notifier).state =
            !extendNavigationRail;
        saveSettings(ref);
      },
      title: const Text('Efekt rozwijania nawigacji'),
      secondary: const Icon(Symbols.visibility),
    );
  }
}
