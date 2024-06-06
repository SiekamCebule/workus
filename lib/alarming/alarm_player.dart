import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workus/alarming/alarm_status_controller.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/models/alarm_status.dart';
import 'package:rxdart/rxdart.dart';

part '__fade_controller.dart';

class AlarmPlayer {
  AlarmPlayer({required this.statusController});

  final AlarmStatusController statusController;
  final _player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
  final _fadeStreamer = _FadeVolumeStreamer();

  Future<void> play(
    AlarmSound sound, {
    double? volume,
    Duration? fadeDuration = const Duration(milliseconds: 3000),
  }) async {
    if (_alarmIsPlaying) {
      stop();
    }
    statusController.play();
    await _player.play(
      AssetSource(sound.filePath),
      mode: PlayerMode.mediaPlayer,
      volume: 0,
    );
    if (fadeDuration != null) {
      final volumes = _fadeStreamer.startFading(
        fadeDuration: fadeDuration,
        calculateVolume: (index, volumeStep) {
          return (index + 1) * volumeStep;
        },
      );
      await for (final volume in volumes) {
        print('fade IN: $volume');
        await _player.setVolume(volume);
      }
    }
    print('End playing');
  }

  Future<void> stop({
    Duration? fadeDuration = const Duration(milliseconds: 3000),
  }) async {
    statusController.stop();
    if (fadeDuration != null) {
      final volumes = _fadeStreamer.startFading(
          fadeDuration: fadeDuration,
          calculateVolume: (step, volumeStep) {
            return (step + 1) * volumeStep;
          },
          reverse: true);
      await for (final volume in volumes) {
        print('fade OUT: $volume');
        await _player.setVolume(volume);
      }
    }
    print('STOP');
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.release();
    await _player.dispose();
  }

  bool get _alarmIsPlaying => statusController.status == AlarmStatus.playing;
}