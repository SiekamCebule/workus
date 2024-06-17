import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/navigator_pop_text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompletedTasksDuringShortBreakDialog extends ConsumerWidget {
  const IncompletedTasksDuringShortBreakDialog({
    super.key,
    required this.onEndShortBreakTap,
  });

  final VoidCallback onEndShortBreakTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.resumeSession),
      content: Text(
        AppLocalizations.of(context)!.endBreakWarning,
      ),
      actions: [
        NavigatorPopTextButton(
          child: Text(
            AppLocalizations.of(context)!.goBack,
            textAlign: TextAlign.end,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onEndShortBreakTap();
          },
          child: Text(
            AppLocalizations.of(context)!.endBreak,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
