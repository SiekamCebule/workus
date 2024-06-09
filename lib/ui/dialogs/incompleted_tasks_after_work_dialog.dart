import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/navigator_pop_text_button.dart';

class IncompletedTasksAfterWorkDialog extends ConsumerWidget {
  const IncompletedTasksAfterWorkDialog({
    super.key,
    required this.onEndSessionTap,
  });

  final VoidCallback onEndSessionTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Zakończyć sesję?'),
      content: const Text(
        'Czy na pewno chcesz zakończyć sesje mimo tego, że nie ukończyłeś jeszcze wszystkich zadań?',
      ),
      actions: [
        const NavigatorPopTextButton(
          child: Text(
            'Wróć',
            textAlign: TextAlign.end,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onEndSessionTap();
          },
          child: const Text(
            'Zakończ sesję',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
