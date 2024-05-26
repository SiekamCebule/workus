import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:workus/work_flow/work_flow_notifier.dart';

Stream<Duration> remainingSessionTimeStream() {
  final subject = PublishSubject<Duration>();
  WorkFlowController.instance.registerOnTick(() {
    subject.add(WorkFlowController.instance.remainingSessionTime);
  });
  return subject;
}
