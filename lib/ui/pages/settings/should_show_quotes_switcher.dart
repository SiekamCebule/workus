import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/settings.dart';

class ShouldShowQuotesSwitcher extends ConsumerWidget {
  const ShouldShowQuotesSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showQuotes = ref.watch(shouldShowQuotesProvider);

    return SwitchListTile(
      value: showQuotes,
      onChanged: (selected) {
        ref.watch(shouldShowQuotesProvider.notifier).state = !showQuotes;
      },
      title: const Text('Cytaty'),
      subtitle: const Text('Czy pokazywać motywujące cytaty w trakcie sesji?'),
      secondary: const Icon(Icons.format_quote_rounded),
    );
  }
}
