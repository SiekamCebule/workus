part of 'alarm_player.dart';

class _MyAudioPlayer {
  WidgetRef? ref;
  AudioPlayer? _player;

  AudioPlayer? get get {
    if (ref == null) {
      return null;
    } else {
      _player ??= AudioPlayer()..setReleaseMode(ReleaseMode.loop);

      return _player;
    }
  }
}
