import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnableAlarmsSwitcher extends ConsumerWidget {
  const EnableAlarmsSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enableAlarms = ref.watch(enableAlarmsProvider);

    return SwitchListTile(
      value: enableAlarms,
      onChanged: (selected) {
        ref.watch(shouldShowQuotesProvider.notifier).state = !enableAlarms;
        saveSettings(ref);
      },
      title: Text(AppLocalizations.of(context)!.playAlarms),
      secondary: const Icon(Symbols.alarm),
    );
  }
}
