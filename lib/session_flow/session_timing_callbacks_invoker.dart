import 'package:workus/session_flow/session_timing_callbacks_registrar.dart';

class SessionTimingCallbacksInvoker {
  SessionTimingCallbacksInvoker({
    required this.registrar,
  });
  final SessionTimingCallbacksRegistrar registrar;

  void invokeOnTickCallbacks() {
    registrar.forEachOnTick((callback) {
      callback();
    });
  }

  void invokeOnSessionEndCallbacks() {
    registrar.forEachOnTick((callback) {
      callback();
    });
  }

  void invokeOnShortBreakCallbacks() {
    registrar.forEachOnTick((callback) {
      callback();
    });
  }
}
