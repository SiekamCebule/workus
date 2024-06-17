import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/constants/platform.dart';
import 'package:workus/ui/layouts/settings/widgets/default_session_duration_dropdown.dart';
import 'package:workus/ui/layouts/settings/widgets/default_short_breaks_interval_dropdown.dart';
import 'package:workus/ui/layouts/settings/widgets/enable_alarms_switcher.dart';
import 'package:workus/ui/layouts/settings/widgets/languages_dropdown.dart';
import 'package:workus/ui/layouts/settings/widgets/session_end_alarm_sound_dropdown.dart';
import 'package:workus/ui/layouts/settings/widgets/short_break_alarm_sound_dropdown.dart';
import 'package:workus/ui/layouts/settings/widgets/should_extend_navigation_rail_switcher.dart';
import 'package:workus/ui/layouts/settings/widgets/should_navigation_rail_extend_effect_switcher.dart';
import 'package:workus/ui/layouts/settings/widgets/should_show_incompleted_tasks_warnings_switcher.dart';
import 'package:workus/ui/layouts/settings/widgets/should_show_notifications_switcher.dart';
import 'package:workus/ui/layouts/settings/widgets/should_show_quotes_switcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdaptiveSettingsScreen extends StatelessWidget {
  const AdaptiveSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutType = LayoutType.fromConstraints(constraints);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.settings),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(5),
                const LanguagesDropdown(),
                const Divider(),
                const ShouldShowIncompletedTasksWarningsSwitcher(),
                const ShouldShowQuotesSwitcher(),
                const ShouldShowNotificationsSwitcher(),
                const EnableAlarmsSwitcher(),
                if (platformIsDesktop && shouldShowNavigationRail(layoutType))
                  const ShouldNavigationRailExtendEffectSwitcher(),
                if (!platformIsDesktop && shouldShowNavigationRail(layoutType))
                  const ShouldExtendNavigationRailSwitcher(),
                const Divider(),
                const DefaultSessionDurationDropdown(),
                const DefaultShortBreaksIntervalDropdown(),
                const Divider(),
                const SessionEndAlarmSoundDropdown(),
                const ShortBreakAlarmSoundDropdown(),
              ],
            ),
          ),
        );
      },
    );
  }
}
