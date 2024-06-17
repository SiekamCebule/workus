import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/app_language.dart';

class LanguagesDropdown extends ConsumerWidget {
  const LanguagesDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(AppLocalizations.of(context)!.defaultBreakInterval),
      leading: const Icon(
        Symbols.language,
      ),
      onTap: () {},
      trailing: DropdownMenu(
        requestFocusOnTap: false,
        initialSelection: ref.watch(languageProvider),
        onSelected: (selectedLanguage) {
          ref.watch(languageProvider.notifier).state = selectedLanguage!;
          saveSettings(ref);
        },
        dropdownMenuEntries: _buildEntries(),
      ),
    );
  }

  List<DropdownMenuEntry<AppLanguage>> _buildEntries() {
    return AppLanguage.values.map((language) {
      return DropdownMenuEntry(
        value: language,
        label: language.name,
      );
    }).toList();
  }
}
