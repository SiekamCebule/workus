import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workus/app_state/global_session_state/session_stats_broadcasting_module.dart';
import 'package:workus/utils/labels.dart';

class RemainingTimeLabel extends ConsumerWidget {
  const RemainingTimeLabel({
    super.key,
    required this.textStyle,
  });

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTimes = ref.watch(sessionStatsBroadcasterProvider).remainingTimes;
    return StreamBuilder(
      initialData: remainingTimes.value,
      stream: remainingTimes,
      builder: (context, snapshot) {
        final remainingTime = snapshot.data!;
        return AnimatedSwitcher(
          duration: Durations.short3,
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
            labelForDuration(context, remainingTime),
            style: GoogleFonts.roboto(
              textStyle: textStyle,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
