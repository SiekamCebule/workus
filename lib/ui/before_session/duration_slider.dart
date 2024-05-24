import 'package:flutter/material.dart';

class DurationSlider extends StatefulWidget {
  const DurationSlider({
    super.key,
    required this.onChanged,
    this.minMinutes = 0,
    required this.maxMinutes,
    required this.interval,
  });

  final void Function(double) onChanged;
  final int minMinutes;
  final int maxMinutes;
  final int interval;

  @override
  State<DurationSlider> createState() => _DurationSliderState();
}

class _DurationSliderState extends State<DurationSlider> {
  int minutes = 0;

  @override
  Widget build(BuildContext context) {
    bool divisable =
        (widget.maxMinutes - widget.minMinutes) % widget.interval == 0;
    if (!divisable) {
      throw Exception(
        'You have to provide a interval which allows to divide the range perfectly, so the (max - min) % interval must be equal to 0',
      );
    }
    int divisions = (widget.maxMinutes - widget.minMinutes) ~/ widget.interval;
    return Slider(
      value: minutes.toDouble(),
      onChanged: (value) {
        setState(() {
          minutes = value.toInt();
        });
        widget.onChanged(value);
      },
      min: widget.minMinutes.toDouble(),
      max: widget.maxMinutes.toDouble(),
      divisions: divisions,
      label: labelFor(minutes),
    );
  }

  String labelFor(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}m';
  }
}
