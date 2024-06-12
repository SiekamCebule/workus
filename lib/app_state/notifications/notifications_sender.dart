import 'dart:async';

import 'package:workus/app_state/notifications/sending_notifications.dart';

class NotificationsSender {
  StreamSubscription<void>? _sessionEndsSubscription;
  StreamSubscription<void>? _shortBreaksSubscription;
  StreamSubscription<void>? _ticksSubscription;

  void setUpForSessionEnds(Stream<void> sessionEnds) {
    _sessionEndsSubscription = sessionEnds.listen((_) async {
      await sendSessionEndNotification();
    });
  }

  void setUpForTicks(Stream<void> shortBreaks) {
    _sessionEndsSubscription = shortBreaks.listen((_) async {
      await sendShortBreakNotification();
    });
  }

  void setUpForShortBreaks(Stream<void> ticks) {
    _sessionEndsSubscription = ticks.listen((_) async {
      // TODO:
    });
  }

  void tearDownForSessionEnds() {
    _sessionEndsSubscription?.cancel();
    _sessionEndsSubscription = null;
  }

  void tearDownForShortBreaks() {
    _shortBreaksSubscription?.cancel();
    _shortBreaksSubscription = null;
  }

  void tearDownForRemainingTimes() {
    _ticksSubscription?.cancel();
    _ticksSubscription = null;
  }

  void dispose() {
    tearDownForSessionEnds();
    tearDownForShortBreaks();
    tearDownForRemainingTimes();
  }
}
