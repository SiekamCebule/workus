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
  late Timer _timer;

  Duration elapsedTime = Duration.zero;
  Duration get remainingTime => _totalDuration - elapsedTime;

  bool isRunning = false;
  bool get isNotRunning => !isRunning;

  void run(Duration duration) {
    if (isRunning) {
      cancel();
    }
    isRunning = true;
    _updateTotalDuration(duration);
    _startTimer(duration);
  }

  void _updateTotalDuration(Duration duration) {
    _totalDuration = duration;
  }

  void _startTimer(Duration duration) {
    _timer = Timer.periodic(tick, (timer) {
      elapsedTime += tick;
      tickCallback?.call();
      if (elapsedTime >= _totalDuration) {
        onEnd?.call();
      }
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
    if (isNotRunning) return;
    _timer.cancel();
    isRunning = false;
  }

  void resume() {
    if (isRunning) return;
    run(_totalDuration);
  }
}
