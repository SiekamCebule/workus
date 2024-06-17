import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showAboutTasksDialog(BuildContext context) {
  final dialog = AlertDialog(
    title: Text(AppLocalizations.of(context)!.taskExplanationTitle),
    content: Text(
      AppLocalizations.of(context)!.taskExplanationText,
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppLocalizations.of(context)!.understood),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (context) => dialog,
  );
}
