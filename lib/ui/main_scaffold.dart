import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:workus/ui/before_session/duration_slider.dart';
import 'package:workus/ui/play_pause_button/play_pause_button.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workus'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const PlayPauseButton(),
            DurationSlider(
              onChanged: (value) {
                print(value);
              },
              maxMinutes: 120,
              interval: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Symbols.checklist),
            label: 'Zadania',
          ),
          NavigationDestination(
            icon: Icon(Symbols.timelapse),
            label: 'Praca',
          ),
          NavigationDestination(
            icon: Icon(Symbols.settings),
            label: 'Ustawienia',
          ),
        ],
      ),
    );
  }
}
