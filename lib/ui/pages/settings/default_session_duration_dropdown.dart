import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/providers/configuration/settings.dart';

class DefaultSessionDurationDropdown extends ConsumerStatefulWidget {
  const DefaultSessionDurationDropdown({super.key});

  @override
  ConsumerState<DefaultSessionDurationDropdown> createState() {
    return _DefaultSessionDurationDropdownState();
  }
}

class _DefaultSessionDurationDropdownState
    extends ConsumerState<DefaultSessionDurationDropdown> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Czas sesji'),
      subtitle: const Text(
        'Jaka ma być domyślna długość sesji na starcie aplikacji?',
      ),
      leading: const Icon(
        Symbols.hourglass_rounded,
      ),
      trailing: DropdownMenu(
        initialSelection: ref.watch(defaultSessionDurationProvider),
        onSelected: (value) {
          ref.watch(defaultSessionDurationProvider.notifier).state = value!;
        },
        dropdownMenuEntries: const [
          DropdownMenuEntry(
            value: Duration(minutes: 15),
            label: '15 minut',
          ),
          DropdownMenuEntry(
            value: Duration(minutes: 30),
            label: '30 minut',
          ),
          DropdownMenuEntry(
            value: Duration(hours: 1),
            label: '1 godzina',
          ),
          DropdownMenuEntry(
            value: Duration(hours: 2),
            label: '2 godziny',
          ),
          DropdownMenuEntry(
            value: Duration(hours: 3),
            label: '3 godziny',
          ),
          DropdownMenuEntry(
            value: Duration(hours: 4),
            label: '4 godziny',
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
