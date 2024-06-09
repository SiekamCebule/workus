import 'package:flutter/material.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';

class PlayPauseButtonForTablets extends StatelessWidget {
  const PlayPauseButtonForTablets({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.6,
      child: const PlayPauseButton(),
    );
  }
}
