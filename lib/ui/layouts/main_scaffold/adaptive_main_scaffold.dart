import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:workus/alarming/alarm_player.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/app_language.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/initialize.dart';
import 'package:workus/app_state/quotes/current_quote.dart';
import 'package:workus/app_state/quotes/quotes_provider.dart';
import 'package:workus/app_state/tasks_management/saving.dart';
import 'package:workus/ui/layouts/main_scaffold/navigation_rail_scaffold.dart';
import 'package:workus/ui/layouts/main_scaffold/page_view_scaffold.dart';

class AdaptiveMainScaffold extends ConsumerStatefulWidget {
  const AdaptiveMainScaffold({super.key});

  @override
  ConsumerState<AdaptiveMainScaffold> createState() => _AdaptiveMainScaffoldState();
}

class _AdaptiveMainScaffoldState extends ConsumerState<AdaptiveMainScaffold>
    with WindowListener {
  late AlarmPlayer _alarmPlayer;
  late ProviderSubscription _languageChanges;
  late AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    Future.microtask(() async {
      if (mounted) {
        await initializeAppState(context, ref);
      }
      _alarmPlayer = ref.read(alarmPlayerProvider);
      _runQuotesGuard();
    });
    WindowManager.instance.addListener(this);
    _lifecycleListener = AppLifecycleListener(
      onInactive: _scheduleTasksSaving,
      onDetach: _scheduleTasksSaving,
    );
    super.initState();
  }

  void _runQuotesGuard() {
    _languageChanges =
        ref.listenManual<AppLanguage>(languageProvider, (previous, current) async {
      await ref
          .read(quotesProvider.notifier)
          .loadFromJson('assets/quotes/${current.code}.json');
      ref.read(currentQuoteProvider.notifier).state =
          ref.read(quotesProvider.notifier).randomQuote();
    });
  }

  @override
  void dispose() {
    Future.microtask(() async {
      await _alarmPlayer.dispose();
    });
    _languageChanges.close();
    WindowManager.instance.removeListener(this);
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutType = LayoutType.fromConstraints(constraints);
        debugPrint('layoutType: $layoutType');
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

  @override
  void onWindowClose() {
    _scheduleTasksSaving();
    super.onWindowClose();
  }

  void _scheduleTasksSaving() {
    Future.microtask(() async {
      await saveAllTasks(ref);
    });
  }
}
