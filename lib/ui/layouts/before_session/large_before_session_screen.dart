import 'package:flutter/material.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/before_session/widgets/before_session_screen_app_bar.dart';
import 'package:workus/ui/layouts/before_session/widgets/session_timing_configurator.dart';
import 'package:workus/ui/reusable/tasks_to_complete.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class LargeBeforeSessionScreen extends StatelessWidget {
  const LargeBeforeSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BeforeSessionScreenAppBar(),
      body: Center(
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
                  child: SessionTimingConfigurator(),
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