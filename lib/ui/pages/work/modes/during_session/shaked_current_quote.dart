import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/quotes/current_quote.dart';
import 'package:workus/ui/animations/shake_animation.dart';
import 'package:workus/ui/pages/work/modes/during_session/quote_widget.dart';

class ShakedCurrentQuote extends ConsumerStatefulWidget {
  const ShakedCurrentQuote({super.key});

  @override
  ConsumerState<ShakedCurrentQuote> createState() => _ShakedQuoteState();
}

class _ShakedQuoteState extends ConsumerState<ShakedCurrentQuote> {
  final _shakeAnimationKey = GlobalKey<ShakeAnimationState>();
  late final Stream<void> _periodicStream;
  late final StreamSubscription<void> _periodicSubscription;

  @override
  void initState() {
    _periodicStream = Stream.periodic(const Duration(seconds: 12));
    _periodicSubscription = _periodicStream.listen((_) {
      _shakeAnimationKey.currentState!.performShakeAnimation();
    });
    super.initState();
  }

  @override
  void dispose() {
    _periodicSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuote = ref.watch(currentQuoteProvider);
    return ShakeAnimation(
      key: _shakeAnimationKey,
      turnFactor: 0.02,
      shakeRounds: 5,
      entireAnimationDuration: const Duration(milliseconds: 1600),
      child: QuoteWidget(
        quote: currentQuote!,
      ),
    );
  }
}
