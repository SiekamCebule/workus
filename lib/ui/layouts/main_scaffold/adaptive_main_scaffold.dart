import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/initialize.dart';
import 'package:workus/app_state/notifications/notifications.dart';
import 'package:workus/ui/layouts/main_scaffold/navigation_rail_scaffold.dart';
import 'package:workus/ui/layouts/main_scaffold/page_view_scaffold.dart';

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
      maybeRequestForNotificationsPermissions();
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
        final layoutType = LayoutType.fromConstraints(constraints);
        print(layoutType);
        return switch (layoutType) {
          LayoutType.verticalPhone ||
          LayoutType.verticalTablet =>
            const PageViewScaffold(),
          LayoutType.foldSquare ||
          LayoutType.horizontalPhone ||
          LayoutType.horizontalTablet ||
          LayoutType.desktop =>
            const NavigationRailScaffold(),
        };
      },
    );
  }
}
