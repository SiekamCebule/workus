import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/dropdown_choices.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      title: Text(AppLocalizations.of(context)!.defaultBreakInterval),
      leading: const Icon(
        Symbols.hourglass_rounded,
      ),
      onTap: () {},
      trailing: DropdownMenu(
        requestFocusOnTap: false,
        initialSelection: ref.watch(defaultShortBreaksIntervalProvider),
        onSelected: (value) {
          ref.watch(defaultShortBreaksIntervalProvider.notifier).state = value!;
          saveSettings(ref);
        },
        dropdownMenuEntries: _buildEntries(),
      ),
    );
  }

  List<DropdownMenuEntry<Duration>> _buildEntries() {
    return defaultShortBreaksIntervalChoices.map((interval) {
      return DropdownMenuEntry(
        value: interval,
        label:
            '${interval.inMinutes} ${AppLocalizations.of(context)!.minutes(interval.inMinutes)}',
      );
    }).toList();
  }
}
