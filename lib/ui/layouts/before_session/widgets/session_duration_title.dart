import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/utils/labels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionDurationTitle extends ConsumerWidget {
  const SessionDurationTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionDuration = ref.watch(sessionDurationProvider);
    final labelForSessionDuration =
        labelForDuration(context, sessionDuration, excludeSeconds: true);

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        children: [
          TextSpan(
            text: '${AppLocalizations.of(context)!.sessionWillLast} ',
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
