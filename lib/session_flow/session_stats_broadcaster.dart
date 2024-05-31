import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/session_flow/session_status_controller.dart';
import 'package:workus/session_flow/session_timing_callbacks_registrar.dart';
import 'package:workus/session_flow/session_timing_controller.dart';

class SessionStatsBroadcaster {
  SessionStatsBroadcaster({
    required this.callbacksRegistrar,
    required this.timingController,
    required this.statusController,
  }) {
    _setup();
  }

  final SessionTimingCallbacksRegistrar callbacksRegistrar;
  final SessionTimingController timingController;
  final SessionStatusController statusController;

  final _elapsedTimes = BehaviorSubject<Duration>();
  final _remainingTimes = BehaviorSubject<Duration>();
  final _timesToShortBreak = BehaviorSubject<Duration?>();
  final _sessionEnds = BehaviorSubject<void>();
  final _sessionShortBreakStarts = BehaviorSubject<void>();
  final _sessionStatuses = BehaviorSubject<WorkSessionStatus>();

  void _setup() {
    callbacksRegistrar.registerOnTick(() {
      _elapsedTimes.add(timingController.elapsedSessionTime);
      _remainingTimes.add(timingController.remainingSessionTime);
      _timesToShortBreak.add(timingController.timeToShortBreak);
    });
    callbacksRegistrar.registerOnSessionEnd(() {
      _sessionEnds.add(null);
    });
    callbacksRegistrar.registerOnShortBreak(() {
      _sessionShortBreakStarts.add(null);
    });
    statusController.registerOnChange((status) {
      _sessionStatuses.add(status);
    });
  }

  void close() {
    _elapsedTimes.close();
    _remainingTimes.close();
    _timesToShortBreak.close();
    _sessionEnds.close();
    _sessionShortBreakStarts.close();
    _sessionStatuses.close();
  }

  ValueStream<Duration> get elapsedTimes => _elapsedTimes.stream;
  ValueStream<Duration> get remainingTimes => _remainingTimes.stream;
  ValueStream<Duration?> get timesToShortBreak => _timesToShortBreak.stream;
  ValueStream<void> get sessionEnds => _sessionEnds.stream;
  ValueStream<void> get sessionShortBreakStarts => _sessionShortBreakStarts.stream;
  ValueStream<WorkSessionStatus> get sessionStatuses => _sessionStatuses.stream;
}
