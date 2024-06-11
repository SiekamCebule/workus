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
        final layoutType = LayoutType.fromConstraints(constraints);
        return Scaffold(
          appBar: const DuringSessionScreenAppBar(),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 5,
                          ),
                          RemainingTimeLabel(
                            textStyle:
                                textStyleForRemainingTimeLabel(layoutType, context),
                          ),
                          if (shouldShowQuotes)
                            const Spacer(
                              flex: 7,
                            ),
                          if (shouldShowQuotes) const ShakedCurrentQuote(),
                          const Spacer(
                            flex: 5,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const PlayPauseButton(),
                    const Spacer(),
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
