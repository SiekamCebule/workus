String labelForDuration(Duration duration) {
  final hours = duration.inMinutes ~/ 60;
  final remainingMinutes = duration.inMinutes % 60;

  var label = '';
  if (hours > 0) {
    label += '$hours godz. ';
  }
  if (remainingMinutes > 0) {
    label += '$remainingMinutes minut';
  }
  return label.isNotEmpty ? label : '0 min';
}
