import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:workus/app.dart';
import 'package:workus/app_state/notifications/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimizable(true);
    WindowManager.instance.setMaximizable(false);
    WindowManager.instance.setFullScreen(false);
    WindowManager.instance.setMaximumSize(const Size(1150, 850));
  }

  initializeNotificationsPlugin();
  maybeRequestForNotificationsPermissions();

  runApp(const ProviderScope(child: App()));
}
