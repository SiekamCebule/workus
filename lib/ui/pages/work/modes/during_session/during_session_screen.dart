import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/pages/work/modes/during_session/remaining_time_label.dart';

class DuringSessionScreen extends ConsumerWidget {
  const DuringSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skup się ;)'),
      ),
      body: const Column(
        children: [
          RemainingTimeLabel(),
        ],
      ),
    );
  }
}
