import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showQuotes = ref.watch(showQuotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: Center(
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Dźwięk alarmu'),
                    subtitle: Text(
                        'Jaki dźwięk ma się odtwarzać po zakończeniu sesji?'),
                    leading: Icon(Icons.alarm),
                  ),
                ),
                DropdownMenu(
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 0, label: 'Alarm nr. 1'),
                    DropdownMenuEntry(value: 1, label: 'Alarm nr. 2'),
                    DropdownMenuEntry(value: 2, label: 'Alarm nr. 3'),
                    DropdownMenuEntry(value: 3, label: 'Alarm nr. 4'),
                  ],
                )
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: ListTile(
                    title: Text('Pokazuj cytaty'),
                    subtitle:
                        Text('Motywujące cytaty pokazywane w trybie pracy'),
                    leading: Icon(Icons.format_quote_rounded),
                  ),
                ),
                Switch(
                  value: showQuotes,
                  onChanged: (selected) {
                    ref.read(showQuotesProvider.notifier).state = !showQuotes;
                  },
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
