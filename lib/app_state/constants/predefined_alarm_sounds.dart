import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final predefinedAlarmSoundsProvider = Provider<List<AlarmSound>>(
  (ref) {
    return [
      AlarmSound(
        id: 'irish_folk',
        filePath: createFilePathForAlarmSoundId('irish_folk'),
      ),
      AlarmSound(
        id: 'spanish_guitar',
        filePath: createFilePathForAlarmSoundId('spanish_guitar'),
      ),
    ];
  },
);

String createFilePathForAlarmSoundId(String id) {
  return 'alarm_sounds/$id.mp3';
}

Map<String, String> alarmSoundNames(BuildContext context) {
  return {
    'irish_folk': AppLocalizations.of(context)!.irishFolk,
    'spanish_guitar': AppLocalizations.of(context)!.spanishGuitar,
  };
}

String nameOfAlarmSound(String alarmSoundId, BuildContext context) {
  return alarmSoundNames(context)[alarmSoundId]!;
}
