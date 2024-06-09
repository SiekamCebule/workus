import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/selected_page.dart';

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

class SlideoutContainerForPageState extends ConsumerState<SlideoutForPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: Durations.medium3,
    );
    _slide = CurvedAnimation(parent: _slideController, curve: Curves.easeIn).drive(
      Tween(
        begin: _forHiding,
        end: _forShowing,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _maybePerformAnimation();

    return SlideTransition(
      position: _slide,
      child: widget.child,
    );
  }

  bool get _shouldShow => ref.watch(selectedPageProvider) == widget.page;
  Offset get _forShowing => const Offset(0.0, 0.0);
  Offset get _forHiding => const Offset(0.0, 1.0);

  void _maybePerformAnimation() {
    if (_shouldShow) {
      _show();
    } else {
      hide();
    }
  }

  void _show() {
    _slideController.forward();
  }

  void hide() {
    _slideController.reverse();
  }
}
