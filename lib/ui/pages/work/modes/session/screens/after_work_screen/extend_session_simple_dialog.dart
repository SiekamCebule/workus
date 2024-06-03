import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExtendSessionSimpleDialog extends ConsumerWidget {
  const ExtendSessionSimpleDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: const Text('O ile przedłużyć sesję?'),
      children: [
        SimpleDialogOption(
          onPressed: () {},
          child: const Text('5 minut'),
        ),
        SimpleDialogOption(
          onPressed: () {},
          child: const Text('15 minut'),
        ),
        SimpleDialogOption(
          onPressed: () {},
          child: const Text('30 minut'),
        ),
      ],
    );
  }
}

Future<void> showExtendSessionSimpleDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) {
        return const ExtendSessionSimpleDialog();
      });
}
