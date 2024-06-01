import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/providers/configuration/work_configuration.dart';
import 'package:workus/utils/labels.dart';

class SessionDurationTitle extends ConsumerWidget {
  const SessionDurationTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionDuration = ref.watch(sessionDurationProvider);
    final labelForSessionDuration =
        labelForDuration(sessionDuration, excludeSeconds: true);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Sesja potrwa ',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: labelForSessionDuration,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
