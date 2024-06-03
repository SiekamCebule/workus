import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/selected_page.dart';

class SlideoutForPage extends ConsumerStatefulWidget {
  const SlideoutForPage({
    super.key,
    required this.page,
    required this.child,
  });

  final AppPage page;
  final Widget child;

  @override
  ConsumerState<SlideoutForPage> createState() => SlideoutContainerForPageState();
}

class SlideoutContainerForPageState extends ConsumerState<SlideoutForPage> {
  @override
  Widget build(BuildContext context) {
    final offset = _shouldShow ? _forShowing : _forHiding;

    return AnimatedSlide(
      offset: offset,
      duration: Durations.medium4,
      curve: Curves.easeIn,
      child: widget.child,
    );
  }

  bool get _shouldShow => ref.watch(selectedPageProvider) == widget.page;
  Offset get _forShowing => const Offset(0.0, 0.0);
  Offset get _forHiding => const Offset(0.0, 1.0);
}
