import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(lightThemeProvider);
    return MaterialApp(
      theme: theme,
      home: ,
    );
  }
}
