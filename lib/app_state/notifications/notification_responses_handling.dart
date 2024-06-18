import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/generic/unary_callbacks_invoker.dart';
import 'package:workus/generic/unary_callbacks_registrar.dart';
import 'package:workus/session_flow/controlling.dart';

final notificationResponseCallbacksRegistrar =
    UnaryCallbacksRegistrar<NotificationResponse>();
final notificationResponseCallbacksInvoker = UnaryCallbacksInvoker<NotificationResponse>(
  registrar: notificationResponseCallbacksRegistrar,
);

Future<void> handleNotificationReponse(
    NotificationResponse details, WidgetRef ref) async {
  final actionId = details.actionId;

  if (actionId != null) {
    switch (actionId) {
      case 'end_session':
        await endSession(ref);
      case 'end_short_break':
        await endShortBreak(ref);
      case 'cancel_session':
        await cancelSession(ref);
    }
  }
}
