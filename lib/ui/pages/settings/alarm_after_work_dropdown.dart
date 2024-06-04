import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmAfterWorkDropdown extends ConsumerWidget {
  const AlarmAfterWorkDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text('Dźwięk alarmu'),
            subtitle: Text('Jaki dźwięk ma się odtwarzać po zakończeniu sesji?'),
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
    );
  }
}
