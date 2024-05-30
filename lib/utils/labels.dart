String shortLabelForHoursMinutesDuration(Duration duration) {
  final hours = duration.inMinutes ~/ 60;
  final remainingMinutes = duration.inMinutes % 60;

  var label = '';
  if (hours > 0) {
    label += '$hours godz. ';
  }
  if (remainingMinutes > 0) {
    label += '$remainingMinutes min.';
  }
  return label.isNotEmpty ? label : '0 min';
}

String labelForHMSDuration(Duration duration) {
  // hours, minutes, seconds
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  List<String> parts = [];

  if (hours > 0) {
    parts.add('$hours godz.');
    parts.add('${atLeastTwoDigit(minutes)} min.');
    parts.add('${atLeastTwoDigit(seconds)} sek.');
  } else if (minutes > 0) {
    parts.add('$minutes min.');
    parts.add('${atLeastTwoDigit(seconds)} sek.');
  } else if (seconds > 0) {
    parts.add('$seconds sek.');
  } else {
    parts.add('0 min.');
  }

  return parts.join(' ');
}

String atLeastTwoDigit(int number) {
  if (number < 10) {
    return '0$number';
  } else {
    return number.toString();
  }
}
