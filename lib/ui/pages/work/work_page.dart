import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/providers/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/ui/pages/work/modes/before_session/before_session_screen.dart';
import 'package:workus/ui/pages/work/modes/session/during_session/during_session_screen.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen.dart';

class WorkPage extends ConsumerWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusesStream = ref.watch(sessionStatsBroadcasterProvider).sessionStatuses;

    return StreamBuilder(
      initialData: statusesStream.value,
      stream: statusesStream,
      builder: (context, snapshot) {
        final status = snapshot.data!;
        return AnimatedSwitcher(
          duration: Durations.medium2,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: appropiateWidgetForWorkStatus(status),
          transitionBuilder: (child, animation) {
            var slideIn = animation.drive(
              Tween(begin: const Offset(0, -1), end: const Offset(0, 0)),
            );
            return SlideTransition(
              position: slideIn,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    );
  }

  Widget appropiateWidgetForWorkStatus(WorkSessionStatus status) {
    return switch (status) {
      WorkSessionStatus.notStarted => const BeforeSessionScreen(),
      WorkSessionStatus.running => const DuringSessionScreen(),
      WorkSessionStatus.pausedByUser => const DuringSessionScreen(),
      WorkSessionStatus.shortBreak => const ShortBreakScreen(),
      WorkSessionStatus.afterWork => const AfterWorkScreen(),
    };
  }
}
