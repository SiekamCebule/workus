import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ShortBreakScreenTimerIcon extends StatelessWidget {
  const ShortBreakScreenTimerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Symbols.timer,
      size: 100,
      weight: 300,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
