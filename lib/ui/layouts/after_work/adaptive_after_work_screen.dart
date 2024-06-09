import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/after_work/widgets/after_work_screen_app_bar.dart';
import 'package:workus/ui/layouts/after_work/widgets/after_work_session_smile_emote_icon.dart';
import 'package:workus/ui/layouts/after_work/widgets/end_session_button.dart';
import 'package:workus/ui/layouts/after_work/widgets/extend_session_button.dart';
import 'package:workus/ui/layouts/after_work/widgets/good_job_caption.dart';
import 'package:workus/ui/reusable/tasks_to_complete.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class AdaptiveAfterWorkScreen extends StatelessWidget {
  const AdaptiveAfterWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
