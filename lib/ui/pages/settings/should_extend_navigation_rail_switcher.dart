import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';

class ShouldExtendNavigationRailSwitcher extends ConsumerWidget {
  const ShouldExtendNavigationRailSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extendNavigationRail = ref.watch(shouldExtendNavigationRailProvider);

    return SwitchListTile(
      value: extendNavigationRail,
      onChanged: (selected) {
        ref.watch(shouldExtendNavigationRailProvider.notifier).state =
            !extendNavigationRail;
        saveSettings(ref);
      },
      title: const Text('Efekt rozwijania nawigacji'),
      secondary: const Icon(Symbols.visibility),
    );
  }
}
