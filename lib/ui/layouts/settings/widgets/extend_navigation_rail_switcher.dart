import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';

class ExtendNavigationRailSwitcher extends ConsumerWidget {
  const ExtendNavigationRailSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extendNavigationRail = ref.watch(extendNavigationRailProvider);

    return SwitchListTile(
      value: extendNavigationRail,
      onChanged: (selected) {
        ref.watch(extendNavigationRailProvider.notifier).state = !extendNavigationRail;
        saveSettings(ref);
      },
      title: const Text('Rozwiń nawigację'),
      secondary: const Icon(Symbols.visibility),
    );
  }
}
