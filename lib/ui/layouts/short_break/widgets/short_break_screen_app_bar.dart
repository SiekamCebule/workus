import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShortBreakScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShortBreakScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.timeForShortBreak),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
