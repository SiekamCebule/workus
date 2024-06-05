import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/providers/configuration/settings.dart';
import 'package:workus/providers/constants/predefined_alarm_sounds.dart';
import 'package:workus/ui/reusable/building_dropdowns.dart';

class ShortBreakAlarmSoundDropdown extends ConsumerWidget {
  const ShortBreakAlarmSoundDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(
          child: ListTile(
            title: Text('Alarm w trakcie przerwy'),
            subtitle: Text('Jaki dźwięk ma się odtwarzać przy rozpoczęciu przerwy?'),
            leading: Icon(Icons.alarm),
          ),
        ),
        DropdownMenu<AlarmSound>(
          initialSelection: ref.watch(shortBreakAlarmSoundProvider),
          onSelected: (sound) {
            ref.watch(shortBreakAlarmSoundProvider.notifier).state = sound!;
          },
          dropdownMenuEntries: buildAlarmSoundDropdownMenuEntries(
            ref.watch(predefinedAlarmSoundsProvider).toList(),
          ),
        )
      ],
    );
  }
}
