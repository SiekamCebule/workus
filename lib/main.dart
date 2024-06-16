import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:workus/app.dart';
import 'package:workus/app_state/notifications/notification_responses_handling.dart';
import 'package:workus/app_state/notifications/notifications.dart';

void backgroundHandler(NotificationResponse responseDetails) {
  print('bg');
  notificationResponseCallbacksInvoker.invoke(responseDetails);
}

void handler(NotificationResponse responseDetails) {
  print('nrml');
  notificationResponseCallbacksInvoker.invoke(responseDetails);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  notificationsPlugin.initialize(
    notificationsPluginInitializationSettings,
    //onDidReceiveBackgroundNotificationResponse: backgroundHandler,
    onDidReceiveNotificationResponse: handler,
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimizable(true);
    WindowManager.instance.setMaximizable(false);
    WindowManager.instance.setFullScreen(false);
    WindowManager.instance.setMaximumSize(const Size(1150, 850));
  }

  runApp(const ProviderScope(child: App()));
}
