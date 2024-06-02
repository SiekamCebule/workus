import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/providers/selected_page.dart';
import 'package:workus/ui/pages/work/tasks_to_complete.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

class ShortBreakScreen extends ConsumerWidget {
  const ShortBreakScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Czas na krótką przerwę :)'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Icon(
              Symbols.sentiment_calm,
              size: 120,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Text(
                'Odejdź na moment od swojej pracy i odpręż się...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Przypomnij za 5 minut'),
                ),
                Gap(15),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Jestem gotów'),
                ),
              ],
            ),
            const Spacer(),
            const SlideoutForPage(
              page: AppPage.work,
              child: TasksToComplete(tasksType: TaskType.duringShortBreak),
            ),
          ],
        ),
      ),
    );
  }
}
