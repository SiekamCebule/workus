import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/notifications/notifications_sender.dart';

final notificationsSenderProvider = Provider(
  (ref) => NotificationsSender(),
);
