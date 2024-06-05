import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/alarm_sound.dart';

final predefinedAlarmSoundsProvider = Provider<List<AlarmSound>>(
  (ref) {
    return [
      AlarmSound(
          id: 'irish_folk',
          filePath: createFilePathForAlarmSoundId('irish_folk'),
          name: 'Irlandzki folk'),
      AlarmSound(
          id: 'spanish_guitar',
          filePath: createFilePathForAlarmSoundId('spanish_guitar'),
          name: 'Hiszpańska gitara'),
    ];
  },
);

String createFilePathForAlarmSoundId(String id) {
  return 'alarm_sounds/$id.mp3';
}
