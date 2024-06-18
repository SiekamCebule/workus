import 'package:flutter/material.dart';
import 'package:workus/ui/reusable/during_sessions_app_bar/cancel_session_icon_button.dart';

class DuringSessionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DuringSessionsAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const [
        CancelSessionIconButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
