enum TaskType {
  beforeSession,
  duringShortBreak,
  afterSession;

  static TaskType fromIndex(int index) => values[index];
}
