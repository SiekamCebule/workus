import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerRemainingTimeNotifier extends Notifier<Duration> {
  TimerRemainingTimeNotifier({
    required this.interval,
    this.intervalCallback,
    this.onEnd,
  });

  final Duration interval;
  VoidCallback? intervalCallback;
  VoidCallback? onEnd;

  late Duration _totalDuration;
  late final Timer _totalTimer;
  late final Timer _periodicTimer;

  Duration _elapsedTime = Duration.zero;
  Duration get _remainingTime => _totalDuration - _elapsedTime;
  bool _isRunning = false;
  bool get _isNotRunning => !_isRunning;

  @override
  Duration build() {
    return Duration.zero;
  }

  void start(Duration duration) {
    _isRunning = true;
    _assignNewDuration(duration);
    _startPeriodicTimer(duration);
    _startTotalTimer(duration);
  }

  void _assignNewDuration(Duration duration) {
    _totalDuration = duration;
    state = _totalDuration;
  }

  void _startPeriodicTimer(Duration duration) {
    _periodicTimer = Timer.periodic(interval, (timer) {
      _elapsedTime += interval;
      state = _remainingTime;
      intervalCallback?.call();
    });
  }

  void _startTotalTimer(Duration duration) {
    _totalTimer = Timer(_totalDuration, () {
      cancel();
      onEnd?.call();
    });
  }

  void cancel() {
    _resetTheState();
    pause();
  }

  void _resetTheState() {
    _totalDuration = Duration.zero;
    _elapsedTime = Duration.zero;
  }

  void pause() {
    if (_isNotRunning) return;
    _cancelTimers();
    _isRunning = false;
  }

  void _cancelTimers() {
    _totalTimer.cancel();
    _periodicTimer.cancel();
  }

  void resume() {
    if (_isRunning) return;
    start(_totalDuration - _elapsedTime);
  }
}
