import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/predefined_alarm_sounds.dart';
import 'package:workus/ui/reusable/building_dropdowns.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionEndAlarmSoundDropdown extends ConsumerWidget {
  const SessionEndAlarmSoundDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(AppLocalizations.of(context)!.endAlarm),
            leading: const Icon(Icons.alarm),
          ),
        ),
        DropdownMenu<AlarmSound>(
          requestFocusOnTap: false,
          initialSelection: ref.watch(sessionEndAlarmSoundProvider),
          onSelected: (sound) {
            ref.watch(sessionEndAlarmSoundProvider.notifier).state = sound!;
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
