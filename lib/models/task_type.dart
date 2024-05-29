enum TaskType {
  beforeSession,
  duringSmallBreak,
  afterSession;

  static TaskType fromIndex(int index) => values[index];
}
