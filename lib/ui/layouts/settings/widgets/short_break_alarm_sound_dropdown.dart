import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/predefined_alarm_sounds.dart';
import 'package:workus/ui/reusable/building_dropdowns.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShortBreakAlarmSoundDropdown extends ConsumerWidget {
  const ShortBreakAlarmSoundDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    print('LANG: $lang');
    print('initialSeleciton of Dropdown: ${ref.watch(shortBreakAlarmSoundProvider)}');
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(AppLocalizations.of(context)!.breakAlarm),
            leading: const Icon(Icons.alarm),
          ),
        ),
        DropdownMenu<AlarmSound>(
          key: ValueKey(lang),
          requestFocusOnTap: false,
          initialSelection: ref.watch(shortBreakAlarmSoundProvider),
          onSelected: (sound) {
            ref.watch(shortBreakAlarmSoundProvider.notifier).state = sound!;
            saveSettings(ref);
          },
          dropdownMenuEntries: buildAlarmSoundDropdownMenuEntries(
            ref.watch(predefinedAlarmSoundsProvider(context)).toList(),
          ),
        )
      ],
    );
  }
}
