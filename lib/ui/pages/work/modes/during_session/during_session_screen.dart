import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/work_configuration.dart';
import 'package:workus/providers/selected_page.dart';
import 'package:workus/ui/pages/work/modes/during_session/next_small_break_info/next_small_break_info_content.dart';
import 'package:workus/ui/pages/work/modes/during_session/remaining_time_label.dart';
import 'package:workus/ui/pages/work/modes/during_session/shaked_current_quote.dart';
import 'package:workus/ui/play_pause_button/play_pause_button.dart';

class DuringSessionScreen extends ConsumerWidget {
  const DuringSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smallBreaksEnabled = ref.watch(smallBreaksEnabledProvider);
    final selectedPage = ref.watch(selectedPageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skup się ;)'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const RemainingTimeLabel(),
            const Spacer(),
            const PlayPauseButton(),
            const Spacer(),
            const Spacer(),
            // TODO: 'if quotesEnabled'
            const ShakedCurrentQuote(),
            const Spacer(),
            if (smallBreaksEnabled)
              Opacity(
                opacity: selectedPage == AppPage.work ? 1 : 0,
                child: AnimatedSlide(
                  offset:
                      selectedPage == AppPage.work ? const Offset(0.5, 1) : Offset.zero,
                  duration: Durations.extralong4,
                  curve: Curves.easeInOut,
                  child: const NextSmallBreakInfoContent(),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ConsumerState