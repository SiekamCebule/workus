import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShouldShowNotificationsSwitcher extends ConsumerWidget {
  const ShouldShowNotificationsSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showNotifications = ref.watch(shouldShowNotificationsProvider);
    return SwitchListTile(
      value: showNotifications,
      onChanged: (value) {
        ref.read(shouldShowNotificationsProvider.notifier).state = value;
        saveSettings(ref);
      },
      secondary: const Icon(Symbols.notifications),
      title: Text(AppLocalizations.of(context)!.showNotifications),
    );
  }
}
