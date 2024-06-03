import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  const ShakeAnimation({
    super.key,
    required this.turnFactor,
    required this.child,
    required this.shakeRounds,
    required this.entireAnimationDuration,
  });

  final Duration entireAnimationDuration;
  final double turnFactor;
  final int shakeRounds;
  final Widget child;

  @override
  State<ShakeAnimation> createState() => ShakeAnimationState();
}

class ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  /// 0.0 means shaking to the left
  /// 0.5 means centernig
  /// 1.0 means shaking to the right
  late final _durationOfOneSideAnimation = widget.entireAnimationDuration *
      0.25 *
      (1 / widget.shakeRounds); // Entire animation consists of 4 parts
  late final AnimationController controller;
  late final Animation<double> turns;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
    )..value = 0.5;
    turns = controller.drive(Tween(
      begin: -widget.turnFactor,
      end: widget.turnFactor,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: turns,
      child: widget.child,
    );
  }

  Future<void> performShakeAnimation() async {
    for (int i = 0; i < widget.shakeRounds; i++) {
      await _performOneShakeRound();
    }
  }

  Future<void> _performOneShakeRound() async {
    await _animateToRight();
    await _animateToCenter();
    await _animateToLeft();
    await _animateToCenter();
  }

  Future<void> _animateToRight() async {
    //controller.value = 0.7;
    await controller.animateTo(
      1.0,
      curve: Curves.linear,
      duration: _durationOfOneSideAnimation,
    );
  }

  Future<void> _animateToLeft() async {
    await controller.animateTo(
      0.0,
      curve: Curves.linear,
      duration: _durationOfOneSideAnimation,
    );
  }

  Future<void> _animateToCenter() async {
    await controller.animateTo(
      0.5,
      curve: Curves.linear,
      duration: _durationOfOneSideAnimation,
    );
  }
}
