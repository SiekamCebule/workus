import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShouldNavigationRailExtendEffectSwitcher extends ConsumerWidget {
  const ShouldNavigationRailExtendEffectSwitcher({super.key});

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
      title: Text(AppLocalizations.of(context)!.navigationExpandEffect),
      secondary: const Icon(Symbols.visibility),
    );
  }
}
