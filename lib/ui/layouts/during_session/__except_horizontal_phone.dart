part of 'adaptive_during_session_screen.dart';

class _ExceptHorizontalPhone extends ConsumerStatefulWidget {
  const _ExceptHorizontalPhone();

  @override
  ConsumerState<_ExceptHorizontalPhone> createState() => __ExceptHorizontalPhoneState();
}

class __ExceptHorizontalPhoneState extends ConsumerState<_ExceptHorizontalPhone> {
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        const Spacer(),
                        const LargeRemainingTimeLabel(),
                        const Spacer(),
                        _appropiatePlayPauseButton(constraints),
                        const Spacer(),
                        if (shouldShowQuotes)
                          const IntrinsicWidth(child: ShakedCurrentQuote()),
                        if (shouldShowQuotes) const Spacer(),
                      ],
                    ),
                  ),
                ),
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
    return shouldShowLargePlayPauseButton(type)
        ? const LargePlayPauseButton()
        : const PlayPauseButton();
  }
}
