import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/ui/dialogs/extend_session_simple_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExtendSessionButton extends ConsumerWidget {
  const ExtendSessionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        showExtendSessionSimpleDialog(context);
      },
      child: Text(AppLocalizations.of(context)!.endSession),
    );
  }
}
