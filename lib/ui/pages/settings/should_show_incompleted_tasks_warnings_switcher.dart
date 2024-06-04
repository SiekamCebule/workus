import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/providers/configuration/settings.dart';

class ShouldShowIncompletedTasksWarningsSwitcher extends ConsumerWidget {
  const ShouldShowIncompletedTasksWarningsSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showWarnings = ref.watch(shouldShowIncompletedTasksWarnings);

    return SwitchListTile(
      value: showWarnings,
      onChanged: (selected) {
        ref.watch(shouldShowIncompletedTasksWarnings.notifier).state = !showWarnings;
      },
      title: const Text('Niewykonane zadania'),
      subtitle: const Text(
        'Czy ostrzegać o niewykonanych zadaniach?',
      ),
      secondary: const Icon(Symbols.warning_rounded),
    );
  }
}
