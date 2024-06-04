import 'package:flutter/material.dart';

class AfterWorkScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AfterWorkScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Praca, praca, i po pracy...'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
