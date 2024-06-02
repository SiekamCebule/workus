import 'package:workus/session_flow/session_status_controller.dart';
import 'package:workus/session_flow/session_timing_callbacks_registrar.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';
import 'package:workus/session_flow/session_timing_controller.dart';

class UserSessionController {
  UserSessionController({
    required this.timingController,
    required this.statusController,
    required this.callbacksRegistrar,
  }) {
    callbacksRegistrar.registerOnShortBreak(_onShortBreakStart);
    callbacksRegistrar.registerOnSessionEnd(_onSessionEnd);
  }
  final SessionTimingController timingController;
  final SessionStatusController statusController;
  final SessionTimingCallbacksRegistrar callbacksRegistrar;

  void start({required SessionTimingConfiguration timingConfiguration}) {
    timingController.start(timingConfiguration: timingConfiguration);
    statusController.start();
  }

  void pause() {
    timingController.pause();
    statusController.pause();
  }

  void resume() {
    timingController.resume();
    statusController.resume();
  }

  void cancel() {
    timingController.cancel();
    statusController.cancel();
  }

  void endShortBreak() {
    timingController.resetShortBreakTimer();
    timingController.resume();
    statusController.endShortBreak();
  }

  void _onShortBreakStart() {
    print('sb');
    timingController.pause();
    statusController.startShortBreak();
  }

  void _onSessionEnd() {
    timingController.cancel();
    statusController.end();
  }
}
