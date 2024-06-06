import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/ui/pages/settings/default_session_duration_dropdown.dart';
import 'package:workus/ui/pages/settings/default_short_breaks_interval_dropdown.dart';
import 'package:workus/ui/pages/settings/session_end_alarm_sound_dropdown.dart';
import 'package:workus/ui/pages/settings/short_break_alarm_sound_dropdown.dart';
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Gap(30),
            SessionEndAlarmSoundDropdown(),
            ShortBreakAlarmSoundDropdown(),
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
