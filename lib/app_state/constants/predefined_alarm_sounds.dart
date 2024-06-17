import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final predefinedAlarmSoundsProvider = Provider.family<List<AlarmSound>, BuildContext>(
  (ref, context) {
    ref.watch(languageProvider);
    print('predefinedAlarmSoundsProvider BUILD');
    print(AppLocalizations.of(context)!.toString());
    return [
      AlarmSound(
        id: 'irish_folk',
        filePath: createFilePathForAlarmSoundId('irish_folk'),
        name: AppLocalizations.of(context)!.irishFolk,
      ),
      AlarmSound(
        id: 'spanish_guitar',
        filePath: createFilePathForAlarmSoundId('spanish_guitar'),
        name: AppLocalizations.of(context)!.spanishGuitar,
      ),
    ];
  },
);

String createFilePathForAlarmSoundId(String id) {
  return 'alarm_sounds/$id.mp3';
}
