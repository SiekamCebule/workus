import 'package:audioplayers/audioplayers.dart';
import 'package:workus/alarming/alarm_status_controller.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/models/alarm_status.dart';

class AlarmPlayer {
  AlarmPlayer({required this.statusController});

  final AlarmStatusController statusController;
  final _player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);

  Future<void> play(AlarmSound sound, {double? volume}) async {
    if (_alarmIsPlaying) {
      stop();
    }
    statusController.play();
    await _player.play(
      AssetSource(sound.filePath),
      mode: PlayerMode.mediaPlayer,
      volume: volume,
    );
  }

  Future<void> stop() async {
    statusController.stop();
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.release();
    await _player.dispose();
  }

  bool get _alarmIsPlaying => statusController.status == AlarmStatus.playing;
}
