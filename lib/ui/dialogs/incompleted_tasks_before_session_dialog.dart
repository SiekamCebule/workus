import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/navigator_pop_text_button.dart';

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
      content: const Text(
        'Nie wykonano jeszcze wszystkich zadań. Czy na pewno chcesz rozpocząć pracę?',
      ),
      actions: [
        const NavigatorPopTextButton(
          child: Text(
            'Wróć',
            textAlign: TextAlign.end,
          ),
        ),
        TextButton(
          key: const ValueKey('start_session_despite_incompleted_tasks_button'),
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
