import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workus/session_flow/controlling.dart';
import 'package:workus/ui/dialogs/navigator_pop_text_button.dart';

class ConfirmSessionCancelDialog extends ConsumerStatefulWidget {
  const ConfirmSessionCancelDialog({super.key});

  @override
  ConsumerState<ConfirmSessionCancelDialog> createState() =>
      _ConfirmSessionCancelDialogState();
}

class _ConfirmSessionCancelDialogState extends ConsumerState<ConfirmSessionCancelDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.cancelSessionQuestion,
      ),
      actions: [
        NavigatorPopTextButton(
          child: Text(
            AppLocalizations.of(context)!.goBack,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            cancelSession(ref);
          },
          child: Text(
            AppLocalizations.of(context)!.cancelSessionConfirm,
          ),
        ),
      ],
    );
  }
}

Future<void> showConfirmSessionCancelDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const ConfirmSessionCancelDialog();
    },
  );
}
