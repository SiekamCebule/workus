import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/initialize.dart';
import 'package:workus/ui/layouts/main_scaffold/large_main_scaffold.dart';
import 'package:workus/ui/layouts/main_scaffold/small_main_scaffold.dart';

class AdaptiveMainScaffold extends ConsumerStatefulWidget {
  const AdaptiveMainScaffold({super.key});

  @override
  ConsumerState<AdaptiveMainScaffold> createState() => _AdaptiveMainScaffoldState();
}

class _AdaptiveMainScaffoldState extends ConsumerState<AdaptiveMainScaffold> {
  @override
  void initState() {
    Future.microtask(() async {
      await initializeAppState(ref);
    });
    super.initState();
  }

  @override
  void dispose() {
    ref.watch(alarmPlayerProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const SmallMainScaffold();
        /*return switch (LayoutType.fromConstraints(constraints)) {
          LayoutType.small => const SmallMainScaffold(),
          LayoutType.medium => const SmallMainScaffold(),
          LayoutType.large => const LargeMainScaffold(),
        };*/
      },
    );
  }
}
