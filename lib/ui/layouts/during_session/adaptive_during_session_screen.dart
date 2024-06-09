import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/before_session/widgets/play_pause_button_for_tablets.dart';
import 'package:workus/ui/layouts/during_session/widgets/during_session_screen_app_bar.dart';
import 'package:workus/ui/layouts/during_session/widgets/large_remaining_time_label.dart';
import 'package:workus/ui/layouts/during_session/widgets/next_small_break_info/next_small_break_info_content.dart';
import 'package:workus/ui/layouts/during_session/widgets/shaked_current_quote.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class AdaptiveDuringSessionScreen extends ConsumerStatefulWidget {
  const AdaptiveDuringSessionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AdaptiveDuringSessionScreenState();
  }
}

class _AdaptiveDuringSessionScreenState
    extends ConsumerState<AdaptiveDuringSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final shouldShowQuotes = ref.watch(shouldShowQuotesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const DuringSessionScreenAppBar(),
          body: Center(
            child: Column(
              children: [
                const Spacer(),
                const LargeRemainingTimeLabel(),
                const Spacer(),
                _appropiatePlayPauseButton(constraints),
                const Spacer(),
                if (shouldShowQuotes) const IntrinsicWidth(child: ShakedCurrentQuote()),
                if (shouldShowQuotes) const Spacer(),
                if (_shouldShowNextSmallBreakInfo)
                  const SlideoutForPage(
                    page: AppPage.work,
                    child: NextSmallBreakInfoContent(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool get _shouldShowNextSmallBreakInfo {
    final smallBreaksAreEnabled = ref.watch(smallBreaksAreEnabledProvider);
    final nextSmallBreakCanBeAwaited =
        ref.watch(sessionTimingControllerProvider).nextSmallBreakCanBeAwaited;
    return smallBreaksAreEnabled && nextSmallBreakCanBeAwaited;
  }

  Widget _appropiatePlayPauseButton(BoxConstraints constraints) {
    final type = LayoutType.fromConstraints(constraints);
    return type == LayoutType.horizontalTablet || type == LayoutType.verticalTablet
        ? const PlayPauseButtonForTablets()
        : const PlayPauseButton();
  }
}
