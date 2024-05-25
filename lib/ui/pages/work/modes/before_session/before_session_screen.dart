import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/work/modes/before_session/mini_break_interval_slider.dart';
import 'package:workus/ui/pages/work/modes/before_session/mini_break_interval_title.dart';
import 'package:workus/ui/pages/work/modes/before_session/session_duration_slider.dart';
import 'package:workus/ui/pages/work/modes/before_session/session_duration_title.dart';
import 'package:workus/ui/pages/work/tasks_to_complete.dart';
import 'package:workus/ui/play_pause_button/play_pause_button.dart';

class BeforeSessionScreen extends ConsumerWidget {
  const BeforeSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Przed sesją'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            PlayPauseButton(),
            SessionDurationTitle(),
            SessionDurationSlider(),
            MiniBreakIntervalTitle(),
            MiniBreakIntervalSlider(),
            Spacer(),
            TasksToComplete(),
          ],
        ),
      ),
    );
  }
}
