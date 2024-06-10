part of 'adaptive_during_session_screen.dart';

class _HorizontalPhone extends ConsumerStatefulWidget {
  const _HorizontalPhone();

  @override
  ConsumerState<_HorizontalPhone> createState() => __HorizontalPhoneState();
}

class __HorizontalPhoneState extends ConsumerState<_HorizontalPhone> {
  @override
  Widget build(BuildContext context) {
    final shouldShowQuotes = ref.watch(shouldShowQuotesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const DuringSessionScreenAppBar(),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    const RemainingTimeTextsColumn(),
                    const Spacer(),
                    const PlayPauseButton(),
                    const Spacer(),
                    if (shouldShowQuotes)
                      const IntrinsicWidth(child: ShakedCurrentQuote()),
                    if (shouldShowQuotes) const Spacer(),
                  ],
                ),
              ),
              if (_shouldShowNextSmallBreakInfo)
                const SlideoutForPage(
                  page: AppPage.work,
                  child: NextSmallBreakInfoContent(),
                ),
            ],
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
}
