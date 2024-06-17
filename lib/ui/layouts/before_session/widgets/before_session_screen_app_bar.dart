import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BeforeSessionScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BeforeSessionScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.beforeSession),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
