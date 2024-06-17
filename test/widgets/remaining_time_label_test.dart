import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workus/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/ui/dialogs/incompleted_tasks_before_session_dialog.dart';
import 'package:workus/ui/layouts/before_session/widgets/large_play_pause_button.dart';
import 'package:workus/ui/layouts/during_session/widgets/remaining_time_label.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';

void main() {
  setUp(() => GoogleFonts.config.allowRuntimeFetching = true);

  testWidgets('appropriate_text_content', (tester) async {
    await tester.runAsync(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});

      final container = ProviderContainer();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );
      await tester.pump();

      await Future.delayed(const Duration(milliseconds: 200));

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

      container.read(sessionDurationProvider.notifier).state =
          const Duration(seconds: 10);
      container.read(shortBreaksIntervalProvider.notifier).state =
          const Duration(seconds: 7);

      await tester.tap(startSessionButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(RemainingTimeLabel), findsOneWidget);

      final texts = <String>[];
      for (int i = 0; i < 8; i++) {
        final remainingTime =
            container.read(sessionTimingControllerProvider).remainingSessionTime;
        final remainingTimeLabelFinder = find.byKey(ValueKey(remainingTime));
        texts.add(tester.widget<Text>(remainingTimeLabelFinder).data!);
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
      }

      expect(texts, [
        '10 sek.',
        '9 sek.',
        '8 sek.',
        '7 sek.',
        '6 sek.',
        '5 sek.',
        '4 sek.',
        '3 sek.',
      ]);
    });
  });
}
