import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/dropdown_choices.dart';

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
      title: const Text('Domyślny czas sesji'),
      leading: const Icon(
        Symbols.hourglass_rounded,
      ),
      trailing: DropdownMenu(
        requestFocusOnTap: false,
        initialSelection: ref.watch(defaultSessionDurationProvider),
        onSelected: (value) {
          ref.watch(defaultSessionDurationProvider.notifier).state = value!;
          saveSettings(ref);
        },
        dropdownMenuEntries: _buildEntries(),
      ),
      onTap: () {},
    );
  }

  List<DropdownMenuEntry<Duration>> _buildEntries() {
    return defaultSessionDurationChoices.map((interval) {
      return DropdownMenuEntry(
        value: interval,
        label: '${interval.inMinutes} minut',
      );
    }).toList();
  }
}
