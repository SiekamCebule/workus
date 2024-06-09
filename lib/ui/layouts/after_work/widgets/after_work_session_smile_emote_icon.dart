import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class AfterWorkSessionSmileEmoteIcon extends StatelessWidget {
  const AfterWorkSessionSmileEmoteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Symbols.sentiment_very_satisfied_rounded,
      size: 100,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
