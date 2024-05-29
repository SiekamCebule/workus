import 'dart:async';
import 'package:flutter/material.dart';

class MyTimer {
  MyTimer({
    this.tick = const Duration(seconds: 1),
    this.tickCallback,
    this.onEnd,
  });

  Duration tick;
  VoidCallback? tickCallback;
  VoidCallback? onEnd;

  late Duration _totalDuration;
  late final Timer _totalTimer;
  late final Timer _periodicTimer;

  Duration elapsedTime = Duration.zero;
  Duration get remainingTime => _totalDuration - elapsedTime;

  bool _isRunning = false;
  bool get _isNotRunning => !_isRunning;

  void start(Duration duration) {
    _isRunning = true;
    _assignNewDuration(duration);
    _startPeriodicTimer(duration);
    _startTotalTimer(duration);
  }

  void _assignNewDuration(Duration duration) {
    _totalDuration = duration;
  }

  void _startPeriodicTimer(Duration duration) {
    _periodicTimer = Timer.periodic(tick, (timer) {
      elapsedTime += tick;
      tickCallback?.call();
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
    elapsedTime = Duration.zero;
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
    start(_totalDuration - elapsedTime);
  }
}
