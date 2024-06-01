import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workus/providers/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/utils/labels.dart';

class RemainingTimeLabel extends ConsumerWidget {
  const RemainingTimeLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTimes = ref.watch(sessionStatsBroadcasterProvider).remainingTimes;
    return StreamBuilder(
      initialData: remainingTimes.value,
      stream: remainingTimes,
      builder: (context, snapshot) {
        final remainingTime = snapshot.data!;
        return AnimatedSwitcher(
          duration: Durations.short2,
          switchInCurve: Curves.linear,
          switchOutCurve: Curves.linear,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Text(
            key: ValueKey(remainingTime),
            labelForDuration(remainingTime),
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.displayMedium,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
