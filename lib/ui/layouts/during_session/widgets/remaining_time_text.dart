import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/polish_language/plural_forms.dart';

enum RemainingTimeType {
  hours,
  minutes,
  seconds,
}

class RemainingTimeText extends ConsumerWidget {
  const RemainingTimeText({
    super.key,
    required this.type,
  });

  final RemainingTimeType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(sessionTimingControllerProvider).remainingSessionTime;
    final number = switch (type) {
      RemainingTimeType.hours => remainingTime.inHours,
      RemainingTimeType.minutes => remainingTime.inMinutes.remainder(60),
      RemainingTimeType.seconds => remainingTime.inSeconds.remainder(60),
    };
    final textAfterNumber = switch (type) {
      RemainingTimeType.hours =>
        getPolishPluralForm(number, 'godzina', 'godziny', 'godzin'),
      RemainingTimeType.minutes =>
        getPolishPluralForm(number, 'minuta', 'minuty', 'minut'),
      RemainingTimeType.seconds =>
        getPolishPluralForm(number, 'sekunda', 'sekundy', 'sekund'),
    };
    return Text('$number $textAfterNumber');
  }
}
