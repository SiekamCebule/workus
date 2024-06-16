import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/app_state/notifications/notifications.dart';
import 'package:workus/app_state/notifications/sending_notifications.dart';

class NotificationsSender {
  late WidgetRef _ref;
  StreamSubscription<void>? _sessionEndsSubscription;
  StreamSubscription<void>? _shortBreaksSubscription;
  StreamSubscription<void>? _ticksSubscription;

  void setUp(WidgetRef ref) {
    _ref = ref;
    _setUpForSessionEnds();
    _setUpForShortBreaks();
    _setUpForTicks();
  }

  void _setUpForSessionEnds() {
    final sessionEnds = _ref.read(sessionStatsBroadcasterProvider).sessionEnds;
    _sessionEndsSubscription = sessionEnds.listen((_) async {
      await showSessionEndNotification();
      await cancelNotification(NotificationIds.shortBreak);
      await cancelNotification(NotificationIds.afterTick);
    });
  }

  void _setUpForShortBreaks() {
    final shortBreaks = _ref.read(sessionStatsBroadcasterProvider).shortBreaks;
    _sessionEndsSubscription = shortBreaks.listen((_) async {
      await showShortBreakNotification();
      await cancelNotification(NotificationIds.afterTick);
    });
  }

  void _setUpForTicks() {
    final ticks = _ref.read(sessionStatsBroadcasterProvider).ticks;
    _sessionEndsSubscription = ticks.listen((_) async {
      final remainingTime =
          _ref.read(sessionTimingControllerProvider).remainingSessionTime;
      await showAfterTickNotification(remainingTime);
    });
  }

  void tearDown() {
    _tearDownForSessionEnds();
    _tearDownForShortBreaks();
    _tearDownForRemainingTimes();
  }

  void _tearDownForSessionEnds() {
    _sessionEndsSubscription?.cancel();
    _sessionEndsSubscription = null;
  }

  void _tearDownForShortBreaks() {
    _shortBreaksSubscription?.cancel();
    _shortBreaksSubscription = null;
  }

  void _tearDownForRemainingTimes() {
    _ticksSubscription?.cancel();
    _ticksSubscription = null;
  }
}
