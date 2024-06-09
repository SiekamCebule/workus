import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/delay_short_break_simple_dialog.dart';

class DelayShortBreakButton extends ConsumerWidget {
  const DelayShortBreakButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        showDelayShortBreakSimpleDialog(context);
      },
      child: const Text('Odłóż przerwę'),
    );
  }
}
