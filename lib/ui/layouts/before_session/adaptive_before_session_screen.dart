import 'package:flutter/material.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/ui/layouts/before_session/large_before_session_screen.dart';
import 'package:workus/ui/layouts/before_session/medium_before_session_screen.dart';
import 'package:workus/ui/layouts/before_session/small_before_session_screen.dart';

class AdaptiveBeforeSessionScreen extends StatelessWidget {
  const AdaptiveBeforeSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return switch (LayoutType.fromWidth(constraints.maxWidth)) {
          LayoutType.small => const SmallBeforeSessionScreen(),
          LayoutType.medium => const MediumBeforeSessionScreen(),
          LayoutType.large => const LargeBeforeSessionScreen(),
        };
      },
    );
  }
}
