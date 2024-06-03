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
  late SessionTimingConfiguration _timingConfiguration;

  void start({required SessionTimingConfiguration timingConfiguration}) {
    _timingConfiguration = timingConfiguration;
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

  void end() {
    timingController.cancel();
    statusController.end();
  }

  void remindShortBreak({required Duration delay}) {
    endShortBreak();
    timingController.startSmallBreakWithCustomInterval(interval: delay);
  }

  void endShortBreak() {
    timingController.resetShortBreakTimer();
    timingController.resume();
    statusController.endShortBreak();
    timingController.startSmallBreakWithCustomInterval(
      interval: _timingConfiguration.shortBreakInterval!,
    );
  }

  void _onShortBreakStart() {
    timingController.pause();
    statusController.startShortBreak();
  }

  void _onSessionEnd() {
    timingController.cancel();
    statusController.changeToAfterWork();
  }
}
