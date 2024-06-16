import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:workus/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/notifications/notification_responses_handling.dart';
import 'package:workus/app_state/notifications/notifications.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/dialogs/incompleted_tasks_before_session_dialog.dart';
import 'package:workus/ui/layouts/before_session/widgets/large_play_pause_button.dart';
import 'package:workus/ui/layouts/during_session/widgets/remaining_time_label.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';

void main() {
  testWidgets('appropriate_text_content', (tester) async {
    await tester.runAsync(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      /*await notificationsPlugin.initialize(
        notificationsPluginInitializationSettings,
        onDidReceiveNotificationResponse: (details) {
          notificationResponseCallbacksInvoker.invoke(details);
        },
      );*/

      /*await notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();*/

      /*if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        await windowManager.ensureInitialized();
        WindowManager.instance.setMinimizable(true);
        WindowManager.instance.setMaximizable(false);
        WindowManager.instance.setFullScreen(false);
        WindowManager.instance.setMaximumSize(const Size(1150, 850));
      }*/

      final container = ProviderContainer();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );
      await tester.pump();
      await Future.delayed(const Duration(seconds: 3));

      print('selected page is ${container.read(selectedPageProvider)}');

      var playPauseButtonFinder = find.byType(PlayPauseButton);
      if (playPauseButtonFinder.allCandidates.isEmpty) {
        playPauseButtonFinder = find.byType(LargePlayPauseButton);
      }
      expect(playPauseButtonFinder, findsOneWidget);

      await tester.tap(playPauseButtonFinder);
      await tester.pumpAndSettle();

      final dialogFinder = find.byType(IncompletedTasksBeforeSessionDialog);
      expect(dialogFinder, findsOneWidget);
      final startSessionButtonFinder =
          find.byKey(const ValueKey('start_session_despite_incompleted_tasks_button'));
      expect(startSessionButtonFinder, findsOneWidget);

      await tester.tap(startSessionButtonFinder);
      await tester.pumpAndSettle();
      final remainingTimeLabelFinder = find.byType(RemainingTimeLabel);
      expect(remainingTimeLabelFinder, findsOneWidget);

      final textFinder = find.textContaining('sek.');
      expect(textFinder, findsOneWidget);

      print(tester.widget<Text>(textFinder).data);
    });
  });
}
