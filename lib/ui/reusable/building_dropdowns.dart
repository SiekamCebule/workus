import 'package:flutter/material.dart';
import 'package:workus/models/alarm_sound.dart';

List<DropdownMenuEntry<AlarmSound>> buildAlarmSoundDropdownMenuEntries(
    List<AlarmSound> sounds) {
  return sounds.map((sound) {
    return DropdownMenuEntry(
      value: sound,
      label: sound.name,
    );
  }).toList();
}
