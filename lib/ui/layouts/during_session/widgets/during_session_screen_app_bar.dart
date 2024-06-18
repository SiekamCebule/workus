import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workus/ui/reusable/during_sessions_app_bar/during_sessions_app_bar.dart';

class DuringSessionScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DuringSessionScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DuringSessionsAppBar(
      title: AppLocalizations.of(context)!.timeForShortBreak,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
