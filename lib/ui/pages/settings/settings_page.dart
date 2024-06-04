import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/settings/alarm_after_work_dropdown.dart';
import 'package:workus/ui/pages/settings/default_session_duration_dropdown.dart';
import 'package:workus/ui/pages/settings/default_short_breaks_interval_dropdown.dart';
import 'package:workus/ui/pages/settings/should_show_incompleted_tasks_warnings_switcher.dart';
import 'package:workus/ui/pages/settings/should_show_quotes_switcher.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: const Center(
        child: Column(
          children: [
            AlarmAfterWorkDropdown(),
            Divider(),
            ShouldShowIncompletedTasksWarningsSwitcher(),
            ShouldShowQuotesSwitcher(),
            Divider(),
            DefaultSessionDurationDropdown(),
            DefaultShortBreaksIntervalDropdown(),
          ],
        ),
      ),
    );
  }
}
