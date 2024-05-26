import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/work/dialogs/navigator_pop_text_button.dart';

class IncompletedTasksBeforeSessionDialog extends ConsumerWidget {
  const IncompletedTasksBeforeSessionDialog({
    super.key,
    required this.onStartSessionTap,
  });

  final VoidCallback onStartSessionTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Zacząć sesję?'),
      content:
          const Text('Nie wykonano jeszcze wszystkich zadań. Czy na pewno chcesz rozpocząć pracę?'),
      actions: [
        const NavigatorPopTextButton(
          child: Text(
            'Wróć do zadań',
            textAlign: TextAlign.end,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onStartSessionTap();
          },
          child: const Text(
            'Rozpocznij sesję',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
