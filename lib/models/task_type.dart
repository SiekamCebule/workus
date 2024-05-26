enum TaskType {
  beforeSession,
  duringMiniBreak,
  afterSession;

  static TaskType fromIndex(int index) => values[index];
}
