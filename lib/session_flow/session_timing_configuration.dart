class SessionTimingConfiguration {
  const SessionTimingConfiguration({
    required this.sessionDuration,
    required this.shortBreaksInterval,
  });

  @override
  bool operator ==(covariant SessionTimingConfiguration other) {
    return sessionDuration == other.sessionDuration &&
        shortBreaksInterval == other.shortBreaksInterval;
  }

  @override
  int get hashCode => Object.hash(sessionDuration, shortBreaksInterval);

  SessionTimingConfiguration copyWith({
    Duration? sessionDuration,
    Duration? shortBreaksInterval,
    bool assignNulls = false,
  }) {
    return SessionTimingConfiguration(
      sessionDuration: sessionDuration ?? this.sessionDuration,
      shortBreaksInterval:
          shortBreaksInterval ?? (assignNulls ? null : this.shortBreaksInterval),
    );
  }

  @override
  String toString() {
    return 'session: $sessionDuration, short breaks interval: $shortBreaksInterval';
  }

  final Duration sessionDuration;
  final Duration? shortBreaksInterval;
}
