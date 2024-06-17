import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/navigator_pop_text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompletedTasksAfterWorkDialog extends ConsumerWidget {
  const IncompletedTasksAfterWorkDialog({
    super.key,
    required this.onEndSessionTap,
  });

  final VoidCallback onEndSessionTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.endSessionConfirm),
      content: Text(
        AppLocalizations.of(context)!.endSessionWarning,
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
            onEndSessionTap();
          },
          child: Text(
            AppLocalizations.of(context)!.endSession,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
