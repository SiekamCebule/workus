class SessionTimingConfiguration {
  const SessionTimingConfiguration({
    required this.totalDuration,
    required this.shortBreakInterval,
  });

  @override
  bool operator ==(covariant SessionTimingConfiguration other) {
    return totalDuration == other.totalDuration &&
        shortBreakInterval == other.shortBreakInterval;
  }

  @override
  int get hashCode => Object.hash(totalDuration, shortBreakInterval);

  final Duration totalDuration;
  final Duration? shortBreakInterval;
}
