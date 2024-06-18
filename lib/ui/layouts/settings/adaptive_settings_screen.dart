import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/constants/platform.dart';
import 'package:workus/app_state/notifications/sending_notifications.dart';
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

class AdaptiveSettingsScreen extends ConsumerWidget {
  const AdaptiveSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(shouldShowNotificationsProvider, (previous, current) async {
      if (current == false) {
        await cancelAllNotifications();
      }
    });

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
                const Gap(5),
                const DefaultShortBreaksIntervalDropdown(),
                const Divider(),
                const SessionEndAlarmSoundDropdown(),
                const Gap(5),
                const ShortBreakAlarmSoundDropdown(),
              ],
            ),
          ),
        );
      },
    );
  }
}
