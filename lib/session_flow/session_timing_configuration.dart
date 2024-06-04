class SessionTimingConfiguration {
  const SessionTimingConfiguration({
    required this.totalDuration,
    required this.shortBreaksInterval,
  });

  @override
  bool operator ==(covariant SessionTimingConfiguration other) {
    return totalDuration == other.totalDuration &&
        shortBreaksInterval == other.shortBreaksInterval;
  }

  @override
  int get hashCode => Object.hash(totalDuration, shortBreaksInterval);

  final Duration totalDuration;
  final Duration? shortBreaksInterval;
}
