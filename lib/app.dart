import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/theme/theme.dart';
import 'package:workus/ui/layouts/main_scaffold/adaptive_main_scaffold.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(lightThemeProvider);
    return MaterialApp(
      theme: theme,
      home: const AdaptiveMainScaffold(),
    );
  }
}
