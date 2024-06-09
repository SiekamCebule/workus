import 'package:flutter/material.dart';

class ShortBreakScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShortBreakScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Czas na krótką przerwę :)'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
