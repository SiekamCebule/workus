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
      tickCallback: _invokeOnTickCallbacks,
    )..onEnd = _executeEndOfSession;
    _smallBreakTimer = MyTimer(tick: _tick)..onEnd = _executeSmallBreak;
  }

  static const _tick = Duration(seconds: 1);
  final List<VoidCallback> _onTickCalllbacks = [];
  final List<VoidCallback> _onStatusChangedCallbacks = [];

  late final MyTimer _smallBreakTimer;
  late final MyTimer _entireSessionTimer;
  late Duration _smallBreakInterval;
  var _status = WorkSessionStatus.nonStarted;

  WorkSessionStatus get status => _status;
  set status(WorkSessionStatus other) {
    _status = other;
    for (var callback in _onStatusChangedCallbacks) {
      callback();
    }
  }

  void _invokeOnTickCallbacks() {
    for (var callback in _onTickCalllbacks) {
      callback();
    }
  }

  Duration get remainingSessionTime => _entireSessionTimer.remainingTime;
  Duration get timeToSmallBreak => _smallBreakTimer.remainingTime;

  Future<void> startSession(Duration duration, Duration smallBreakInterval) async {
    _entireSessionTimer.start(duration);
    _smallBreakTimer.start(smallBreakInterval);
    _invokeOnTickCallbacks();
    status = WorkSessionStatus.running;
    _smallBreakInterval = smallBreakInterval;
  }

  void _executeEndOfSession() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Ending a session');
    _cancelTimers();
    status = WorkSessionStatus.ended;
  }

  void _executeSmallBreak() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Exeucting a small break');
    pauseSession();
    status = WorkSessionStatus.miniBreak;
  }

  void pauseSession() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Pausing a session');
    status = WorkSessionStatus.paused;
    _entireSessionTimer.pause();
    _smallBreakTimer.pause();
  }

  void resumeSession() {
    _ensureCorrectState({WorkSessionStatus.paused}, 'Resuming a session');
    status = WorkSessionStatus.running;
    _entireSessionTimer.resume();
    _smallBreakTimer.resume();
  }

  void endSmallBreak() {
    _ensureCorrectState({WorkSessionStatus.miniBreak}, 'Ending a mini break');
    status = WorkSessionStatus.running;
    _smallBreakTimer.start(_smallBreakInterval);
  }

  void _ensureCorrectState(Iterable<WorkSessionStatus> allowedStates, String? precedingOperation) {
    if (!allowedStates.contains(status)) {
      throw StateError(
        '$precedingOperation: The state is $status, but it\'s requried to be one of these from $allowedStates',
      );
    }
  }

  void cancelSession() {
    _ensureCorrectState(
      {WorkSessionStatus.miniBreak, WorkSessionStatus.paused, WorkSessionStatus.running},
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

  void registerOnStatusChange(VoidCallback callback) => _onStatusChangedCallbacks.add(callback);

  void clearCallbacks() {
    _onTickCalllbacks.clear();
    _onStatusChangedCallbacks.clear();
  }
}
