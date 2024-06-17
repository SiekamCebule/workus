part of 'alarm_player.dart';

class _MyAudioPlayer {
  WidgetRef? ref;
  AudioPlayer? _player;

  AudioPlayer? get get {
    if (ref == null) {
      print('REF IS NULL');
      return null;
    } else {
      if (_player == null) {
        print('PLAYER IS NULL SO INIT');
        _player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
      }

      return _player;
    }
  }
}
