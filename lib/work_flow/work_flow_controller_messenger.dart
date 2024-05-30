import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/work_flow/work_flow_controller.dart';

class WorkFlowControllerMessenger {
  static WorkFlowControllerMessenger get instance {
    _instance ??= WorkFlowControllerMessenger._private(WorkFlowController.instance);
    return _instance!;
  }

  WorkFlowControllerMessenger._private(WorkFlowController controller)
      : _controllerInstance = controller {
    _setupMessaging();
  }

  @visibleForTesting
  factory WorkFlowControllerMessenger.forTesting(WorkFlowController controllerInstance) {
    return WorkFlowControllerMessenger._private(controllerInstance);
  }

  static WorkFlowControllerMessenger? _instance;
  final WorkFlowController _controllerInstance;

  void _setupMessaging() {
    _controllerInstance.registerOnTick(() {
      _elapsedSessionTime.add(_controllerInstance.elapsedSessionTime);
      _remainingSessionTime.add(_controllerInstance.remainingSessionTime);
      print(
          'Time to small break which will have been added to stream by the end of function: ${_controllerInstance.timeToSmallBreak}');
      _timeToSmallBreak.add(_controllerInstance.timeToSmallBreak);
    });
    _controllerInstance.registerOnStatusChange((status) {
      _workSessionStatus.add(status);
    });
  }

  final _elapsedSessionTime = BehaviorSubject<Duration>();
  final _remainingSessionTime = BehaviorSubject<Duration>();
  final _timeToSmallBreak = BehaviorSubject<Duration?>();
  final _workSessionStatus = BehaviorSubject<WorkSessionStatus>();

  void dispose() {
    _elapsedSessionTime.close();
    _remainingSessionTime.close();
    _timeToSmallBreak.close();
    _workSessionStatus.close();
  }

  ValueStream<Duration> get elapsedSessionTimeStream => _elapsedSessionTime.stream;
  ValueStream<Duration> get remainingSessionTimeStream => _remainingSessionTime.stream;
  ValueStream<Duration?> get timeToSmallBreakStream => _timeToSmallBreak.stream;
  ValueStream<WorkSessionStatus> get workSessionStatusStream => _workSessionStatus.stream;
}
