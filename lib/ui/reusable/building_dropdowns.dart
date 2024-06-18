import 'package:flutter/material.dart';
import 'package:workus/app_state/constants/predefined_alarm_sounds.dart';
import 'package:workus/models/alarm_sound.dart';

List<DropdownMenuEntry<AlarmSound>> buildAlarmSoundDropdownMenuEntries(
    List<AlarmSound> sounds, BuildContext context) {
  return sounds.map((sound) {
    return DropdownMenuEntry(
      value: sound,
      label: nameOfAlarmSound(sound.id, context),
    );
  }).toList();
}
