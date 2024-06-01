import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SmallBreakTimerIcon extends StatelessWidget {
  const SmallBreakTimerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Symbols.timer,
      weight: 300,
      color: Theme.of(context).colorScheme.primary,
      size: 50,
    );
  }
}
