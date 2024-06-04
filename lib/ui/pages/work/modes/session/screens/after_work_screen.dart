import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/selected_page.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen/after_work_screen_app_bar.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen/after_work_session_smile_emote_icon.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen/end_session_button.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen/extend_session_button.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen/good_job_caption.dart';
import 'package:workus/ui/pages/work/tasks_to_complete.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class AfterWorkScreen extends ConsumerWidget {
  const AfterWorkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: AfterWorkScreenAppBar(),
      body: Column(
        children: [
          Spacer(),
          AfterWorkSessionSmileEmoteIcon(),
          Gap(30),
          GoodJobCaption(),
          Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExtendSessionButton(),
              EndSessionButton(),
            ],
          ),
          Spacer(),
          SlideoutForPage(
            page: AppPage.work,
            child: TasksToComplete(tasksType: TaskType.afterSession),
          ),
        ],
      ),
    );
  }
}
