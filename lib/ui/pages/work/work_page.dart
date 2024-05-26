import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/ui/pages/work/modes/before_session/before_session_screen.dart';
import 'package:workus/ui/pages/work/modes/during_session/during_session_screen.dart';
import 'package:workus/work_flow/work_flow_notifier.dart';

class WorkPage extends ConsumerWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workStatus = WorkFlowController.instance.status;

    return AnimatedSwitcher(
      duration: Durations.long2,
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      child: appropiateWidgetForWorkStatus(workStatus),
    );
  }

  Widget appropiateWidgetForWorkStatus(WorkSessionStatus status) {
    return switch (status) {
      WorkSessionStatus.nonStarted => const BeforeSessionScreen(),
      WorkSessionStatus.running => const DuringSessionScreen(),
      _ => const Placeholder(),
    };
  }
}
