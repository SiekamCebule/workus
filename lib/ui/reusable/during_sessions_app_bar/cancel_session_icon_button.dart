import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/ui/dialogs/confirm_session_cancel_dialog.dart';

class CancelSessionIconButton extends ConsumerWidget {
  const CancelSessionIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        showConfirmSessionCancelDialog(context);
      },
      icon: const Icon(Symbols.cancel),
    );
  }
}
