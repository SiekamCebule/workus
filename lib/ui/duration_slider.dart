import 'package:flutter/material.dart';

class DurationSlider extends StatefulWidget {
  const DurationSlider({
    super.key,
    this.onChanged,
    this.onSlideEnd,
    required this.initialMinutes,
    this.minMinutes = 0,
    required this.maxMinutes,
    required this.interval,
  });

  final void Function(Duration)? onChanged;
  final void Function(Duration)? onSlideEnd;
  final int initialMinutes;
  final int minMinutes;
  final int maxMinutes;
  final int interval;

  @override
  State<DurationSlider> createState() => _DurationSliderState();
}

class _DurationSliderState extends State<DurationSlider> {
  late int minutes;

  @override
  void initState() {
    super.initState();
    minutes = widget.initialMinutes;
  }

  @override
  Widget build(BuildContext context) {
    bool divisable = (widget.maxMinutes - widget.minMinutes) % widget.interval == 0;
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
          minutes = value.round();
        });
        widget.onChanged?.call(Duration(minutes: minutes));
      },
      onChangeEnd: (value) {
        widget.onSlideEnd?.call(Duration(minutes: value.round()));
      },
      min: widget.minMinutes.toDouble(),
      max: widget.maxMinutes.toDouble(),
      divisions: divisions,
    );
  }
}
