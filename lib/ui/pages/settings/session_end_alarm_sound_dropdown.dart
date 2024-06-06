import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/providers/configuration/saving.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/providers/constants/predefined_alarm_sounds.dart';
import 'package:workus/ui/reusable/building_dropdowns.dart';

class SessionEndAlarmSoundDropdown extends ConsumerWidget {
  const SessionEndAlarmSoundDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(
          child: ListTile(
            title: Text('Alarm zakończenia'),
            leading: Icon(Icons.alarm),
          ),
        ),
        DropdownMenu<AlarmSound>(
          initialSelection: ref.watch(sessionEndAlarmSoundProvider),
          onSelected: (sound) {
            ref.watch(sessionEndAlarmSoundProvider.notifier).state = sound!;
            saveSettings(ref);
          },
          dropdownMenuEntries: buildAlarmSoundDropdownMenuEntries(
            ref.watch(predefinedAlarmSoundsProvider).toList(),
          ),
        )
      ],
    );
  }
}
