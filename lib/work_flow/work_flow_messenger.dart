import 'package:flutter/material.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/work_flow/work_flow_controller.dart';

class WorkFlowMessenger {
  static WorkFlowMessenger get instance {
    _instance ??= WorkFlowMessenger._private(WorkFlowController.instance);
    return _instance!;
  }

  WorkFlowMessenger._private(WorkFlowController controller)
      : _controllerInstance = controller {
    _setupMessaging();
  }

  @visibleForTesting
  factory WorkFlowMessenger.forTesting(WorkFlowController controllerInstance) {
    return WorkFlowMessenger._private(controllerInstance);
  }

  static WorkFlowMessenger? _instance;
  final WorkFlowController _controllerInstance;

  void _setupMessaging() {
    _controllerInstance.registerOnTick(() {
      _elapsedSessionTime.add(_controllerInstance.elapsedSessionTime);
      _remainingSessionTime.add(_controllerInstance.remainingSessionTime);
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
