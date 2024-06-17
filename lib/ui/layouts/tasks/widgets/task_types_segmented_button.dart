import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/task_type.dart';
import 'package:workus/app_state/selected_tasks_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskTypesSegmentedButton extends ConsumerStatefulWidget {
  const TaskTypesSegmentedButton({super.key});

  @override
  ConsumerState<TaskTypesSegmentedButton> createState() =>
      _TaskTypesSegmentedButtonState();
}

class _TaskTypesSegmentedButtonState extends ConsumerState<TaskTypesSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    final selectedTaskType = ref.watch(selectedTaskTypeProvider);
    final selectedIndex = selectedTaskType.index;

    return SegmentedButton<int>(
      showSelectedIcon: false,
      onSelectionChanged: (index) {
        ref.read(selectedTaskTypeProvider.notifier).state =
            TaskType.fromIndex(index.first);
      },
      segments: [
        ButtonSegment(
          value: 0,
          label: Text(AppLocalizations.of(context)!.beforeWork),
        ),
        ButtonSegment(
          value: 1,
          label: Text(AppLocalizations.of(context)!.duringBreaks),
        ),
        ButtonSegment(
          value: 2,
          label: Text(AppLocalizations.of(context)!.afterWork),
        ),
      ],
      selected: {selectedIndex},
    );
  }
}
