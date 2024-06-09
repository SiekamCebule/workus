import 'package:flutter/material.dart';

class DuringSessionScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DuringSessionScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Skup się ;)'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
