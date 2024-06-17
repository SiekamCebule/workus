import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workus/alarming/alarm_status_controller.dart';
import 'package:workus/models/alarm_sound.dart';
import 'package:workus/models/alarm_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '__fade_controller.dart';
part '__my_audio_player.dart';

class AlarmPlayer {
  AlarmPlayer({required this.statusController});

  final AlarmStatusController statusController;
  final _player = _MyAudioPlayer();
  final _fadeStreamer = _FadeVolumeStreamer();

  Future<void> play(
    AlarmSound sound, {
    double? volume,
    Duration? fadeDuration = const Duration(milliseconds: 1800),
  }) async {
    if (_alarmIsPlaying) {
      stop(fadeDuration: null);
    }
    statusController.play();
    await _player.get?.play(
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
        await _player.get?.setVolume(volume);
      }
    }
  }

  Future<void> stop({
    Duration? fadeDuration = const Duration(milliseconds: 1800),
  }) async {
    if (fadeDuration != null) {
      final volumes = _fadeStreamer.startFading(
          fadeDuration: fadeDuration,
          calculateVolume: (step, volumeStep) {
            return (step + 1) * volumeStep;
          },
          reverse: true);
      await for (final volume in volumes) {
        await _player.get?.setVolume(volume);
      }
    }
    await _player.get?.stop();
    statusController.stop();
  }

  Future<void> dispose() async {
    await _player.get?.release();
    await _player.get?.dispose();
  }

  set widgetRef(WidgetRef ref) {
    _player.ref = ref;
  }

  bool get _alarmIsPlaying => statusController.status == AlarmStatus.playing;
}
