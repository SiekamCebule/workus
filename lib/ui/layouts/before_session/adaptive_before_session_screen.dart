import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/ui/layouts/before_session/widgets/before_session_screen_app_bar.dart';
import 'package:workus/ui/layouts/before_session/widgets/large_play_pause_button.dart';
import 'package:workus/ui/layouts/before_session/widgets/session_timing_configurator.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';
import 'package:workus/ui/reusable/tasks_to_complete.dart';

part '__horizontal_phone.dart';
part '__large_horizontal.dart';
part '__vertical.dart';

class AdaptiveBeforeSessionScreen extends StatelessWidget {
  const AdaptiveBeforeSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final content = switch (LayoutType.fromConstraints(constraints)) {
          LayoutType.verticalPhone => const _Vertical(),
          LayoutType.horizontalPhone => const _HorizontalPhone(),
          LayoutType.verticalTablet => const _Vertical(),
          LayoutType.horizontalTablet => const _LargeHorizontal(),
          LayoutType.foldSquare => const _Vertical(),
          LayoutType.desktop => const _LargeHorizontal(),
        };
        return Scaffold(
          appBar: const BeforeSessionScreenAppBar(),
          body: Center(
            child: content,
          ),
        );
      },
    );
  }
}
