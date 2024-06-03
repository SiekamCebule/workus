import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/work/dialogs/navigator_pop_text_button.dart';

class IncompletedTasksDuringShortBreakDialog extends ConsumerWidget {
  const IncompletedTasksDuringShortBreakDialog({
    super.key,
    required this.onEndShortBreakTap,
  });

  final VoidCallback onEndShortBreakTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Przejść spowrotem do sesji?'),
      content: const Text(
        'Czy chcesz zakończyć przerwę mimo, że nie wykonałeś jeszcze wszystkich zadań?',
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
            onEndShortBreakTap();
          },
          child: const Text(
            'Zakończ przerwę',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
