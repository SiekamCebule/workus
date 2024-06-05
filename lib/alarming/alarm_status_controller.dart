import 'package:workus/models/alarm_status.dart';
import 'package:workus/generic/on_change_callbacks_invoker.dart';

class AlarmStatusController {
  AlarmStatusController({required this.callbacksInvoker});

  OnChangeCallbacksInvoker<AlarmStatus> callbacksInvoker;
  var _status = AlarmStatus.notPlaying;

  void play() {
    _status = AlarmStatus.playing;
    _invokeCallbacks();
  }

  void stop() {
    _status = AlarmStatus.notPlaying;
    _invokeCallbacks();
  }

  void _invokeCallbacks() {
    callbacksInvoker.invoke(_status);
  }

  AlarmStatus get status => _status;
}
