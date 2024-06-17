import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DuringSessionScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DuringSessionScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.focus),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
