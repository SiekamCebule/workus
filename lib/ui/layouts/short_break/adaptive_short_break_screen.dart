import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/short_break/widgets/end_short_break_button.dart';
import 'package:workus/ui/layouts/short_break/widgets/short_break_main_caption.dart';
import 'package:workus/ui/layouts/short_break/widgets/delay_short_break_button.dart';
import 'package:workus/ui/layouts/short_break/widgets/short_break_screen_app_bar.dart';
import 'package:workus/ui/layouts/short_break/widgets/short_break_screen_timer_icon.dart';
import 'package:workus/ui/reusable/tasks_to_complete.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class AdaptiveShortBreakScreen extends StatelessWidget {
  const AdaptiveShortBreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ShortBreakScreenAppBar(),
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 4,
            ),
            ShortBreakScreenTimerIcon(),
            Gap(30),
            ShortBreakMainCaption(),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DelayShortBreakButton(),
                EndShortBreakButton(),
              ],
            ),
            Spacer(
              flex: 4,
            ),
            SlideoutForPage(
              page: AppPage.work,
              child: TasksToComplete(tasksType: TaskType.duringShortBreak),
            ),
          ],
        ),
      ),
    );
  }
}
