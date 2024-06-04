import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/selected_page.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen/end_short_break_button.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen/short_break_main_caption.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen/short_break_remind_button.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen/short_break_screen_app_bar.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen/short_break_screen_calm_emote_icon.dart';
import 'package:workus/ui/pages/work/tasks_to_complete.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class ShortBreakScreen extends ConsumerWidget {
  const ShortBreakScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: ShortBreakScreenAppBar(),
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 4,
            ),
            ShortBreakScreenCalmEmoteIcon(),
            Gap(30),
            ShortBreakMainCaption(),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShortBreakRemindButton(),
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
