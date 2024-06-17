import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/navigator_pop_text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompletedTasksBeforeSessionDialog extends ConsumerWidget {
  const IncompletedTasksBeforeSessionDialog({
    super.key,
    required this.onStartSessionTap,
  });

  final VoidCallback onStartSessionTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.startSession),
      content: Text(
        AppLocalizations.of(context)!.startSessionWarning,
      ),
      actions: [
        NavigatorPopTextButton(
          child: Text(
            AppLocalizations.of(context)!.goBack,
            textAlign: TextAlign.end,
          ),
        ),
        TextButton(
          key: const ValueKey('start_session_despite_incompleted_tasks_button'),
          onPressed: () {
            Navigator.of(context).pop();
            onStartSessionTap();
          },
          child: Text(
            AppLocalizations.of(context)!.startSessionConfirm,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
