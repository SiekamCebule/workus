import 'package:workus/models/work_session_status.dart';

class SessionStatusController {
  var _status = WorkSessionStatus.notStarted;
  final List<Function(WorkSessionStatus status)> _onChangeCallbacks = [];

  WorkSessionStatus get status => _status;

  set status(WorkSessionStatus other) {
    _status = other;
    _invokeOnChangeCallbacks();
  }

  void registerOnChange(Function(WorkSessionStatus status) callback) {
    _onChangeCallbacks.add(callback);
  }

  void _invokeOnChangeCallbacks() {
    for (var callback in _onChangeCallbacks) {
      callback(status);
    }
  }

  void start() {
    _ensureCorrectState({WorkSessionStatus.notStarted}, 'Starting the session');
    status = WorkSessionStatus.running;
  }

  void pause() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Pausing the session');
    status = WorkSessionStatus.pausedByUser;
  }

  void resume() {
    _ensureCorrectState({WorkSessionStatus.pausedByUser}, 'Resuming the session');
    status = WorkSessionStatus.running;
  }

  void startShortBreak() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Starting a small break');
    status = WorkSessionStatus.shortBreak;
  }

  void endShortBreak() {
    _ensureCorrectState({WorkSessionStatus.shortBreak}, 'Ending the small break');
    status = WorkSessionStatus.running;
  }

  void changeToAfterWork() {
    _ensureCorrectState({WorkSessionStatus.running}, 'Changing to \'after work\' status');
    status = WorkSessionStatus.afterWork;
  }

  void end() {
    _ensureCorrectState({WorkSessionStatus.afterWork}, 'Ending the session');
    status = WorkSessionStatus.notStarted;
  }

  void cancel() {
    _ensureCorrectState(
      {
        WorkSessionStatus.shortBreak,
        WorkSessionStatus.pausedByUser,
        WorkSessionStatus.running
      },
      'Cancelling the session',
    );
    status = WorkSessionStatus.notStarted;
  }

  void _ensureCorrectState(
    Iterable<WorkSessionStatus> allowedStates,
    String? precededOperation,
  ) {
    if (!allowedStates.contains(status)) {
      throw StateError(
        '$precededOperation: The state is $status, but it\'s requried to be one of these from $allowedStates',
      );
    }
  }
}
