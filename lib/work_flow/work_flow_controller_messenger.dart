import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/work_flow/work_flow_controller.dart';

class WorkFlowControllerMessenger {
  static WorkFlowControllerMessenger get instance {
    _instance ??= WorkFlowControllerMessenger._private();
    return _instance!;
  }

  WorkFlowControllerMessenger._private() {
    _setupMessaging();
  }

  static WorkFlowControllerMessenger? _instance;

  void _setupMessaging() {
    WorkFlowController.instance.registerOnTick(() {
      _remainingSessionTime.add(WorkFlowController.instance.remainingSessionTime);
      _timeToSmallBreak.add(WorkFlowController.instance.timeToSmallBreak);
    });
    WorkFlowController.instance.registerOnStatusChange(() {
      _workSessionStatus.add(WorkFlowController.instance.status);
    });
  }

  final _remainingSessionTime = PublishSubject<Duration>();
  final _timeToSmallBreak = PublishSubject<Duration>();
  final _workSessionStatus = PublishSubject<WorkSessionStatus>();

  void dispose() {
    _remainingSessionTime.close();
    _timeToSmallBreak.close();
    _workSessionStatus.close();
  }

  Stream<Duration> get remainingSessionTimeStream => _remainingSessionTime;

  Stream<Duration> get timeToSmallBreakStream => _timeToSmallBreak;

  Stream<WorkSessionStatus> get workSessionStatusStream => _workSessionStatus;
}
