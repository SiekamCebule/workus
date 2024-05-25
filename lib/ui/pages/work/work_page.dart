import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/work_status.dart';
import 'package:workus/ui/pages/work/modes/before_session/before_session_screen.dart';
import 'package:workus/ui/pages/work/modes/during_session/during_session_screen.dart';

class WorkPage extends ConsumerWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workStatus = ref.watch(workStatusProvider);

    return AnimatedSwitcher(
      duration: Durations.long2,
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      child: appropiateWidgetForWorkStatus(workStatus),
    );
  }

  Widget appropiateWidgetForWorkStatus(WorkStatus status) {
    return switch (status) {
      WorkStatus.nonStarted => const BeforeSessionScreen(),
      WorkStatus.running => const DuringSessionScreen(),
      _ => const Placeholder(),
    };
  }
}
