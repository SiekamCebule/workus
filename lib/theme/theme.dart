import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lightThemeProvider = Provider(
  (ref) {
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ref.watch(lightColorSchemeProvider),
    );
  },
);

final lightColorSchemeProvider = Provider<ColorScheme>(
  (ref) {
    final scheme = SeedColorScheme.fromSeeds(
      primaryKey: Colors.yellow,
      secondaryKey: Colors.white,
      tertiary: Colors.orangeAccent,
      tones: FlexTones.candyPop(Brightness.light),
      brightness: Brightness.light,
    );
    return scheme;
  },
);
