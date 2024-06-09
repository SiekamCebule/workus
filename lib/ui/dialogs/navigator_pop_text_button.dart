import 'package:flutter/material.dart';

class NavigatorPopTextButton extends StatelessWidget {
  const NavigatorPopTextButton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: child,
    );
  }
}
