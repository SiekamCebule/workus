import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/notifications/notifications.dart';

class NotificationResponsesHandler {
  late WidgetRef _ref;

  void handle(NotificationResponse details, WidgetRef ref) {
    _ref = ref;
    final notificationId = details.id!;
    final actionId = details.actionId!;

    switch (notificationId) {
      case NotificationIds.afterWork:
        _handleAfterWorkNotificationResponse(actionId);
      case NotificationIds.shortBreak:
        _handleShortBreakNotificationResponse(actionId);
      case NotificationIds.afterTick:
        _handleTicksNotificationResponse(actionId);
    }
  }

  void _handleAfterWorkNotificationResponse(String actionId) {
    switch (actionId) {
      case 'end_session':
        _ref.watch(userSessionControllerProvider).end();
    }
  }

  void _handleShortBreakNotificationResponse(String actionId) {
    switch (actionId) {
      case 'end_short_break':
        _ref.watch(userSessionControllerProvider).endShortBreak();
    }
  }

  void _handleTicksNotificationResponse(String actionId) {
    switch (actionId) {
      case 'cancel_session':
        _ref.watch(userSessionControllerProvider).cancel();
    }
  }
}
