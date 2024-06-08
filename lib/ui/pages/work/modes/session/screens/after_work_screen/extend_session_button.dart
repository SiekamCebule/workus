import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/work/dialogs/extend_session_simple_dialog.dart';

class ExtendSessionButton extends ConsumerWidget {
  const ExtendSessionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        showExtendSessionSimpleDialog(context);
      },
      child: const Text('Przedłuż sesję'),
    );
  }
}
