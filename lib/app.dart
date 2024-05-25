import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/theme/theme.dart';
import 'package:workus/ui/main_scaffold/main_scaffold.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(lightThemeProvider);
    return MaterialApp(
      theme: theme,
      home: const MainScaffold(),
    );
  }
}
