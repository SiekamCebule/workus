import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/providers/configuration/settings.dart';

class DefaultShortBreaksIntervalDropdown extends ConsumerStatefulWidget {
  const DefaultShortBreaksIntervalDropdown({super.key});

  @override
  ConsumerState<DefaultShortBreaksIntervalDropdown> createState() =>
      _DefaultShortBreaksIntervalDropdownState();
}

class _DefaultShortBreaksIntervalDropdownState
    extends ConsumerState<DefaultShortBreaksIntervalDropdown> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Odstęp pomiędzy przerwami'),
      subtitle: const Text(
        'Jaki ma być domyślny odstęp pomiędzy przerwami na starcie aplikacji?',
      ),
      leading: const Icon(
        Symbols.hourglass_rounded,
      ),
      onTap: () {},
      trailing: DropdownMenu(
        initialSelection: ref.watch(defaultShortBreaksIntervalProvider),
        onSelected: (value) {
          ref.watch(defaultShortBreaksIntervalProvider.notifier).state = value!;
        },
        dropdownMenuEntries: const [
          DropdownMenuEntry(
            value: Duration(minutes: 10),
            label: '10 minut',
          ),
          DropdownMenuEntry(
            value: Duration(minutes: 15),
            label: '15 minut',
          ),
          DropdownMenuEntry(
            value: Duration(minutes: 20),
            label: '20 minut',
          ),
          DropdownMenuEntry(
            value: Duration(minutes: 25),
            label: '25 minut',
          ),
          DropdownMenuEntry(
            value: Duration(minutes: 30),
            label: '30 minut',
          ),
          DropdownMenuEntry(
            value: Duration(minutes: 40),
            label: '40 minut',
          ),
        ],
      ),
    );
  }
}
