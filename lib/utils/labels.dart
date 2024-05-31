String labelForDuration(Duration duration, {bool excludeSeconds = false}) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  List<String> parts = [];

  if (hours > 0) {
    parts.add('$hours godz.');
    parts.add('${atLeastTwoDigit(minutes)} min.');
    if (!excludeSeconds) {
      parts.add('${atLeastTwoDigit(seconds)} sek.');
    }
  } else if (minutes > 0) {
    parts.add('$minutes min.');
    if (!excludeSeconds) {
      parts.add('${atLeastTwoDigit(seconds)} sek.');
    }
  } else if (seconds > 0 && !excludeSeconds) {
    parts.add('$seconds sek.');
  } else {
    parts.add('0 min.');
  }

  return parts.join(' ');
}

String atLeastTwoDigit(int number) {
  return number.toString().padLeft(2, '0');
}
