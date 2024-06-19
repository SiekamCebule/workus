import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/app_state/notifications/sending_notifications.dart';

class NotificationsSender {
  late BuildContext _context;
  late WidgetRef _ref;
  StreamSubscription<void>? _sessionEndsSubscription;
  StreamSubscription<void>? _shortBreaksSubscription;
  StreamSubscription<void>? _ticksSubscription;

  void setUp(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;
    _setUpForSessionEnds();
    _setUpForShortBreaks();
    _setUpForTicks();
  }

  void _setUpForSessionEnds() {
    final sessionEnds = _ref.read(sessionStatsBroadcasterProvider).sessionEnds;
    _sessionEndsSubscription = sessionEnds.listen((_) async {
      if (!_ref.read(shouldShowNotificationsProvider)) return;
      await showSessionEndNotification(_context);
      //await cancelNotification(NotificationIds.shortBreak);
      //await cancelNotification(NotificationIds.afterTick);
    });
  }

  void _setUpForShortBreaks() {
    final shortBreaks = _ref.read(sessionStatsBroadcasterProvider).shortBreaks;
    _sessionEndsSubscription = shortBreaks.listen((_) async {
      if (!_ref.read(shouldShowNotificationsProvider)) return;
      await showShortBreakNotification(_context);
      //await cancelNotification(NotificationIds.afterTick);
    });
  }

  void _setUpForTicks() {
    final ticks = _ref.read(sessionStatsBroadcasterProvider).ticks;
    _sessionEndsSubscription = ticks.listen((_) async {
      if (!_ref.read(shouldShowNotificationsProvider)) return;
      final remainingTime =
          _ref.read(sessionTimingControllerProvider).remainingSessionTime;
      await showAfterTickNotification(_context, remainingTime);
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
