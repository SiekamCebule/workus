import 'package:flutter/material.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/work_flow/my_timer.dart';

class WorkFlowController {
  static WorkFlowController get instance {
    _instance ??= WorkFlowController._private();
    return _instance!;
  }

  static WorkFlowController? _instance;

  WorkFlowController._private() {
    _entireSessionTimer = MyTimer(
      tick: _tick,
      tickCallback: () {
        _entireSessionTimerCallbackInvoked = true;
        _tryInvokeOnTickCallbacks();
      },
    )..onEnd = _executeEndOfSession;
    _smallBreakTimer = MyTimer(
      tick: _tick,
      tickCallback: () {
        _smallBreakTimerCallbackInvoked = true;
        _tryInvokeOnTickCallbacks();
      },
    )..onEnd = _executeSmallBreak;
  }

  void _tryInvokeOnTickCallbacks({bool force = false}) {
    if (_entireSessionTimerCallbackInvoked && _smallBreakTimerCallbackInvoked || force) {
      _entireSessionTimerCallbackInvoked = false;
      _smallBreakTimerCallbackInvoked = false;
      for (var callback in _onTickCalllbacks) {
        callback();
      }
    }
  }

  @visibleForTesting
  factory WorkFlowController.forTesting() {
    return WorkFlowController._private();
  }

  static const _tick = Duration(seconds: 1);
  final List<VoidCallback> _onTickCalllbacks = [];
  final List<Function(WorkSessionStatus status)> _onStatusChangedCallbacks = [];
  late final MyTimer _smallBreakTimer;
  late final MyTimer _entireSessionTimer;
  late Duration _smallBreakInterval;
  var _status = WorkSessionStatus.nonStarted;
  bool _entireSessionTimerCallbackInvoked = false;
  bool _smallBreakTimerCallbackInvoked = false;

  Duration get elapsedSessionTime => _entireSessionTimer.elapsedTime;
  Duration get remainingSessionTime => _entireSessionTimer.remainingTime;
  Duration? get timeToSmallBreak {
    if (_smallBreaksAreEnabled) {
      return _smallBreakTimer.remainingTime;
    }
    return null;
  }

  bool get _smallBreaksAreEnabled => _smallBreakInterval != Duration.zero;

  Future<void> startSession({
    required Duration sessionDuration,
    required Duration smallBreakInterval,
  }) async {
    _smallBreakInterval = smallBreakInterval;
    _startEntireSessionTimerIfNonZeroDuration(sessionDuration);
    _startSmallBreakTimerIfNonZeroInterval(smallBreakInterval);
    _tryInvokeOnTickCallbacks(force: true);
    status = WorkSessionStatus.running;
  }

  void _startEntireSessionTimerIfNonZeroDuration(Duration duration) {
    if (duration != Duration.zero) {
      _entireSessionTimer.run(duration);
    } else {
      throw StateError('The duration of a session must be a non-zero one');
    }
  }

  void _startSmallBreakTimerIfNonZeroInterval(Duration smallBreakInterval) {
    if (_smallBreakInterval != Duration.zero) {
      _smallBreakTimer.run(smallBreakInterval);
    }
  }

  void _executeEndOfSession() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Ending a session');
    _cancelTimers();
    status = WorkSessionStatus.ended;
  }

  void _executeSmallBreak() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Exeucting a small break');
    _pauseTimers();
    _moveSmallBreakTimerToBeginning();
    status = WorkSessionStatus.miniBreak;
  }

  void _pauseTimers() {
    _entireSessionTimer.pause();
    _pauseSmallBreakTimerIfEnabled();
  }

  void _pauseSmallBreakTimerIfEnabled() {
    if (_smallBreaksAreEnabled) {
      _smallBreakTimer.pause();
    }
  }

  void _moveSmallBreakTimerToBeginning() {
    _smallBreakTimer.elapsedTime = Duration.zero;
  }

  void pauseSession() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Pausing a session');
    _pauseTimers();
    status = WorkSessionStatus.pausedByUser;
  }

  void resumeSession() {
    _ensureCorrectState({WorkSessionStatus.pausedByUser}, 'Resuming a session');
    _resumeTimers();
    status = WorkSessionStatus.running;
  }

  void _resumeTimers() {
    _entireSessionTimer.resume();
    _resumeSmallBreakTimerIfEnabled();
  }

  void _resumeSmallBreakTimerIfEnabled() {
    if (_smallBreaksAreEnabled) {
      _smallBreakTimer.resume();
    }
  }

  void endSmallBreak() {
    _ensureCorrectState({WorkSessionStatus.miniBreak}, 'Ending a mini break');
    _resumeTimers();
    status = WorkSessionStatus.running;
  }

  void _ensureCorrectState(
      Iterable<WorkSessionStatus> allowedStates, String? precedingOperation) {
    if (!allowedStates.contains(status)) {
      throw StateError(
        '$precedingOperation: The state is $status, but it\'s requried to be one of these from $allowedStates',
      );
    }
  }

  void cancelSession() {
    _ensureCorrectState(
      {
        WorkSessionStatus.miniBreak,
        WorkSessionStatus.pausedByUser,
        WorkSessionStatus.running
      },
      'Cancelling a session',
    );
    status = WorkSessionStatus.cancelled;
    _cancelTimers();
  }

  void _cancelTimers() {
    _entireSessionTimer.cancel();
    _smallBreakTimer.cancel();
  }

  void registerOnTick(VoidCallback callback) => _onTickCalllbacks.add(callback);

  void registerOnStatusChange(void Function(WorkSessionStatus status) callback) =>
      _onStatusChangedCallbacks.add(callback);

  void clearCallbacks() {
    _onTickCalllbacks.clear();
    _onStatusChangedCallbacks.clear();
  }

  WorkSessionStatus get status => _status;
  set status(WorkSessionStatus other) {
    _status = other;
    for (var callback in _onStatusChangedCallbacks) {
      callback(status);
    }
  }

  void dispose() {
    _cancelTimers();
    clearCallbacks();
  }
}
