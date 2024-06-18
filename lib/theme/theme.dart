import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lightThemeProvider = Provider(
  (ref) {
    final colorScheme = ref.watch(lightColorSchemeProvider);
    return FlexThemeData.light(
      useMaterial3: true,
      colorScheme: colorScheme,
    );
  },
);

final lightColorSchemeProvider = Provider<ColorScheme>(
  (ref) {
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.yellow[400]!,
      brightness: Brightness.light,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );
    return scheme;
  },
);
