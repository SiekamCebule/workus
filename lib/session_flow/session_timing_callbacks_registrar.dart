import 'package:flutter/material.dart';

class SessionTimingCallbacksRegistrar {
  final List<VoidCallback> _onTickCalllbacks = [];
  final List<VoidCallback> _onSessionEndCallbacks = [];
  final List<VoidCallback> _onShortBreakCallbacks = [];

  void registerOnTick(VoidCallback callback) {
    _onTickCalllbacks.add(callback);
  }

  void registerOnSessionEnd(VoidCallback callback) {
    _onSessionEndCallbacks.add(callback);
  }

  void registerOnShortBreak(VoidCallback callback) {
    _onShortBreakCallbacks.add(callback);
  }

  void forEachOnTick(Function(VoidCallback) function) {
    for (var callback in _onTickCalllbacks) {
      function(callback);
    }
  }

  void forEachOnSessionEnd(Function(VoidCallback) function) {
    for (var callback in _onSessionEndCallbacks) {
      function(callback);
    }
  }

  void forEachOnShortBreak(Function(VoidCallback) function) {
    for (var callback in _onShortBreakCallbacks) {
      function(callback);
    }
  }
}
