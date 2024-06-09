import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:workus/ui/layouts/before_session/widgets/short_breaks_interval_slider.dart';
import 'package:workus/ui/layouts/before_session/widgets/short_break_interval_title/short_break_interval_title.dart';
import 'package:workus/ui/layouts/before_session/widgets/session_duration_slider.dart';
import 'package:workus/ui/layouts/before_session/widgets/session_duration_title.dart';

class SessionTimingConfigurator extends ConsumerWidget {
  const SessionTimingConfigurator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: const Column(
        children: [
          SessionDurationTitle(),
          SessionDurationSlider(),
          Gap(5),
          ShortBreaksIntervalTitle(),
          ShortBreaksIntervalSlider(),
        ],
      ),
    );
  }
}
