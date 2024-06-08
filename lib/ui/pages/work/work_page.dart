import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/ui/layouts/before_session/adaptive_before_session_screen.dart';
import 'package:workus/ui/pages/work/modes/session/during_session/during_session_screen.dart';
import 'package:workus/ui/pages/work/modes/session/screens/after_work_screen.dart';
import 'package:workus/ui/pages/work/modes/session/screens/short_break_screen.dart';

class WorkPage extends ConsumerStatefulWidget {
  const WorkPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _WorkPageState();
  }
}

class _WorkPageState extends ConsumerState<WorkPage> {
  late final StreamSubscription _sessionEndsSubscription;
  late final StreamSubscription _shortBreaksSubscription;

  @override
  void initState() {
    Future.microtask(() {
      _setupSessionEndAlarming();
      _setupShortBreakAlarming();
    });

    super.initState();
  }

  @override
  void dispose() {
    _sessionEndsSubscription.cancel();
    _shortBreaksSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

  void _setupSessionEndAlarming() {
    _shortBreaksSubscription =
        ref.watch(sessionStatsBroadcasterProvider).sessionEnds.listen((_) {
      ref.watch(alarmPlayerProvider).play(ref.watch(
            sessionEndAlarmSoundProvider,
          ));
    });
  }

  void _setupShortBreakAlarming() {
    _sessionEndsSubscription =
        ref.watch(sessionStatsBroadcasterProvider).shortBreaks.listen((_) {
      ref.watch(alarmPlayerProvider).play(
            ref.watch(shortBreakAlarmSoundProvider),
            volume: 0.5,
          );
    });
  }

  Widget appropiateWidgetForWorkStatus(WorkSessionStatus status) {
    return switch (status) {
      WorkSessionStatus.notStarted => const AdaptiveBeforeSessionScreen(),
      WorkSessionStatus.running => const DuringSessionScreen(),
      WorkSessionStatus.pausedByUser => const DuringSessionScreen(),
      WorkSessionStatus.shortBreak => const ShortBreakScreen(),
      WorkSessionStatus.afterWork => const AfterWorkScreen(),
    };
  }
}
