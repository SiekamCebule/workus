import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ShortBreakScreenCalmEmoteIcon extends StatelessWidget {
  const ShortBreakScreenCalmEmoteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Symbols.sentiment_calm,
      size: 100,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
