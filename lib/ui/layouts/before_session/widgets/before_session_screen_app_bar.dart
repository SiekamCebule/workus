import 'package:flutter/material.dart';

class BeforeSessionScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BeforeSessionScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Przed sesją'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
