import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/pages/work/modes/session/during_session/next_small_break_info/next_small_break_info_content.dart';
import 'package:workus/ui/pages/work/modes/session/during_session/large_remaining_time_label.dart';
import 'package:workus/ui/pages/work/modes/session/during_session/shaked_current_quote.dart';
import 'package:workus/ui/play_pause_button/play_pause_button.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class DuringSessionScreen extends ConsumerWidget {
  const DuringSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smallBreaksAreEnabled = ref.watch(smallBreaksAreEnabledProvider);
    final shouldShowQuotes = ref.watch(shouldShowQuotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skup się ;)'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const LargeRemainingTimeLabel(),
            const Spacer(),
            const PlayPauseButton(),
            const Spacer(),
            if (shouldShowQuotes) const ShakedCurrentQuote(),
            if (shouldShowQuotes) const Spacer(),
            if (smallBreaksAreEnabled)
              const SlideoutForPage(
                page: AppPage.work,
                child: NextSmallBreakInfoContent(),
              ),
          ],
        ),
      ),
    );
  }
}
