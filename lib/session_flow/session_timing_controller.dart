import 'package:workus/session_flow/session_timer.dart';
import 'package:workus/session_flow/session_timing_callbacks_invoker.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';

class SessionTimingController {
  SessionTimingController({required this.callbacksInvoker}) {
    _entireSessionTimer = SessionTimer(
      onTick: _onEntireSessionTimerTick,
      onEnd: callbacksInvoker.invokeOnSessionEndCallbacks,
    );
    _shortBreakTimer = SessionTimer(
      onTick: _onShortBreakTimerTick,
      onEnd: callbacksInvoker.invokeOnShortBreakCallbacks,
    );
  }

  void _onEntireSessionTimerTick() {
    _invokedEntireSessionTimerOnTick = true;
    _maybeInvokeCallbacks();
  }

  void _onShortBreakTimerTick() {
    _invokedShortBreakTimerOnTick = true;
    _maybeInvokeCallbacks();
  }

  void _maybeInvokeCallbacks({bool force = false}) {
    if (_shouldInvokeCallbacks(force: force)) {
      _resetCallbackInvocationStatuses();
      callbacksInvoker.invokeOnTickCallbacks();
    }
  }

  bool _shouldInvokeCallbacks({required bool force}) {
    return (_invokedEntireSessionTimerOnTick && _invokedShortBreakTimerOnTick) ||
        force ||
        _shortBreaksDisabled;
  }

  void _resetCallbackInvocationStatuses() {
    _invokedEntireSessionTimerOnTick = false;
    _invokedShortBreakTimerOnTick = false;
  }

  bool _invokedEntireSessionTimerOnTick = false;
  bool _invokedShortBreakTimerOnTick = false;

  final SessionTimingCallbacksInvoker callbacksInvoker;
  late SessionTimer _entireSessionTimer;
  late SessionTimer? _shortBreakTimer;

  late SessionTimingConfiguration _timingConfiguration;
  bool get _shortBreaksEnabled => _shortBreakTimer != null;
  bool get _shortBreaksDisabled => !_shortBreaksEnabled;

  void start({
    required SessionTimingConfiguration timingConfiguration,
  }) {
    _timingConfiguration = timingConfiguration;
    _tryRunningEntireSessionTimer();
    _setUpShortBreakTimer();
    _maybeInvokeCallbacks(force: true);
  }

  void _tryRunningEntireSessionTimer() {
    if (_timingConfiguration.sessionDuration != Duration.zero) {
      _entireSessionTimer.run(_timingConfiguration.sessionDuration);
    } else {
      throw StateError('The duration of a session must be a non-zero one');
    }
  }

  void _setUpShortBreakTimer() {
    if (_timingConfiguration.shortBreaksInterval == null) {
      _shortBreakTimer = null;
    } else {
      _shortBreakTimer?.run(_timingConfiguration.shortBreaksInterval!);
    }
  }

  void pause() {
    _entireSessionTimer.pause();
    _shortBreakTimer?.pause();
    _maybeInvokeCallbacks(force: true);
  }

  void resume() {
    _entireSessionTimer.resume();
    _shortBreakTimer?.resume();
    _maybeInvokeCallbacks(force: true);
  }

  void cancel() {
    _entireSessionTimer.cancel();
    _shortBreakTimer?.cancel();
    _maybeInvokeCallbacks(force: true);
  }

  void resetEntireSessionTimer() {
    _entireSessionTimer.elapsedTime = Duration.zero;
  }

  void resetShortBreakTimer() {
    _shortBreakTimer?.elapsedTime = Duration.zero;
  }

  void startSmallBreakWithCustomInterval({
    required Duration interval,
  }) {
    if (_shortBreaksEnabled) {
      if (_shortBreakTimer!.isRunning) {
        _shortBreakTimer!.run(interval);
        _maybeInvokeCallbacks(force: true);
      }
    }
  }

  Duration get elapsedSessionTime => _entireSessionTimer.elapsedTime;
  Duration get remainingSessionTime => _entireSessionTimer.remainingTime;
  Duration? get timeToShortBreak {
    if (_shortBreaksEnabled) {
      return _shortBreakTimer!.remainingTime;
    }
    return null;
  }
}
