import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';

class ShouldShowIncompletedTasksWarningsSwitcher extends ConsumerWidget {
  const ShouldShowIncompletedTasksWarningsSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showWarnings = ref.watch(shouldShowIncompletedTasksWarningsProvider);

    return SwitchListTile(
      value: showWarnings,
      onChanged: (selected) {
        ref.watch(shouldShowIncompletedTasksWarningsProvider.notifier).state =
            !showWarnings;
        saveSettings(ref);
      },
      title: const Text('Ostrzegaj o niewykonanych zadaniach'),
      secondary: const Icon(Symbols.warning_rounded),
    );
  }
}
