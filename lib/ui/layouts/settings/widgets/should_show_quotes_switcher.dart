import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/saving.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShouldShowQuotesSwitcher extends ConsumerWidget {
  const ShouldShowQuotesSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showQuotes = ref.watch(shouldShowQuotesProvider);

    return SwitchListTile(
      value: showQuotes,
      onChanged: (selected) {
        ref.watch(shouldShowQuotesProvider.notifier).state = !showQuotes;
        saveSettings(ref);
      },
      title: Text(AppLocalizations.of(context)!.showQuotes),
      secondary: const Icon(Icons.format_quote_rounded),
    );
  }
}
