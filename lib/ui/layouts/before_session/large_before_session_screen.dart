import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/pages/work/modes/before_session/short_breaks_interval_slider.dart';
import 'package:workus/ui/pages/work/modes/before_session/short_break_interval_title/short_break_interval_title.dart';
import 'package:workus/ui/pages/work/modes/before_session/session_duration_slider.dart';
import 'package:workus/ui/pages/work/modes/before_session/session_duration_title.dart';
import 'package:workus/ui/pages/work/tasks_to_complete.dart';
import 'package:workus/ui/play_pause_button/play_pause_button.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class LargeBeforeSessionScreen extends ConsumerWidget {
  const LargeBeforeSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Przed sesją'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      SessionDurationTitle(),
                      SessionDurationSlider(),
                      Gap(5),
                      ShortBreaksIntervalTitle(),
                      ShortBreaksIntervalSlider(),
                    ],
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                PlayPauseButton(),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
            Spacer(),
            SlideoutForPage(
              page: AppPage.work,
              child: TasksToComplete(tasksType: TaskType.beforeSession),
            ),
          ],
        ),
      ),
    );
  }
}
